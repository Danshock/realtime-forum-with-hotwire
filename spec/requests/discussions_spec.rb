# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/discussions', type: :request do

  before(:all) do
    @user = FactoryBot.create(:user)
    @category = FactoryBot.create(:category)
  end

  before(:each) do
    sign_in(@user)
  end

  let(:valid_attributes) {
    {
      name: 'foo',
      pinned: true,
      closed: false,
      user_id: @user.id,
      category_id: @category.id
     }
  }

  let(:invalid_attributes) {
    {
      name: '',
      pinned: true,
      closed: false
    }
  }

  describe 'GET /index' do
    it 'renders a successful response' do
      Discussion.create!(valid_attributes)
      get discussions_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      discussion = Discussion.create!(valid_attributes)
      get discussions_url(discussion)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_discussion_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'renders a successful response' do
      discussion = Discussion.create!(valid_attributes)
      get edit_discussion_url(discussion)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Discussion' do
        expect {
          post discussions_url, params: { discussion: valid_attributes }
        }.to change(Discussion, :count).by(1)
      end

      it 'redirects to the created discussion' do
        post discussions_url, params: { discussion: valid_attributes }
        expect(response).to redirect_to(discussion_url(Discussion.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Discussion' do
        expect {
          post discussions_url, params: { discussion: invalid_attributes }
        }.to change(Discussion, :count).by(0)
      end

      it 'renders a successful response (i.e. to display the \'new\' template)' do
        post discussions_url, params: { discussion: invalid_attributes }
        puts ">> #{response.status}"
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) {
        {
          name: 'baz',
          pinned: true,
          closed: true,
          user_id: @user.id,
          category_id: @category.id
         }
      }

      it 'updates the requested discussion' do
        discussion = Discussion.create!(valid_attributes)
        patch discussion_url(discussion), params: { discussion: new_attributes }
        discussion.reload
        expect(discussion.name).to eq('baz')
      end

      it 'redirects to the discussion' do
        discussion = Discussion.create!(valid_attributes)
        patch discussion_url(discussion), params: { discussion: new_attributes }
        discussion.reload
        expect(response).to redirect_to(discussion_url(discussion))
      end
    end

    context 'with invalid parameters' do
      it 'renders a successful response (i.e. to display the \'edit\' template)' do
        discussion = Discussion.create!(valid_attributes)
        patch discussion_url(discussion), params: { discussion: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested discussion' do
      discussion = Discussion.create!(valid_attributes)
      expect {
        delete discussion_url(discussion)
      }.to change(Discussion, :count).by(-1)
    end

    it 'redirects to the discussions list' do
      discussion = Discussion.create!(valid_attributes)
      delete discussion_url(discussion)
      expect(response).to redirect_to(discussions_url)
    end
  end
end
