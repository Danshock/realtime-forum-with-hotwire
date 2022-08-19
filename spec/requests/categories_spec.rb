# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/categories', type: :request do

  before(:all) do
    @user = FactoryBot.create(:user)
  end

  before(:each) do
    sign_in(@user)
  end

  let(:valid_attributes) {
    {
      name: 'foo',
      discussions_count: 1
    }
  }

  describe 'GET /index' do
    it 'renders a successful response' do
      Category.create!(valid_attributes)
      get categories_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      category = Category.create!(valid_attributes)
      get category_url(category)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_category_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      category = Category.create!(valid_attributes)
      get edit_category_url(category)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Category' do
        expect {
          post categories_url, params: { category: valid_attributes }
        }.to change(Category, :count).by(1)
      end

      it 'redirects to the created category' do
        post categories_url, params: { category: valid_attributes }
        expect(response).to redirect_to(category_url(Category.last))
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) {
        {
          name: 'baz',
          discussions_count: 1
        }
      }

      it 'updates the requested category' do
        category = Category.create!(valid_attributes)
        patch category_url(category), params: { category: new_attributes }
        category.reload
        expect(category.name).to eq('baz')
      end

      it 'redirects to the category' do
        category = Category.create!(valid_attributes)
        patch category_url(category), params: { category: new_attributes }
        category.reload
        expect(response).to redirect_to(category_url(category))
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested category' do
      category = Category.create!(valid_attributes)
      expect {
        delete category_url(category)
      }.to change(Category, :count).by(-1)
    end

    it 'redirects to the categories list' do
      category = Category.create!(valid_attributes)
      delete category_url(category)
      expect(response).to redirect_to(categories_url)
    end
  end
end
