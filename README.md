# README

Ruby on Rails v6 Forum with some hotwire magic ✨  

Getting started:

To get started with the app, clone the repo and then install the needed gems:
```
bundle install --without production
```

Next, migrate the database:
```
bin/rails db:migrate
```

Finally, run the test suite to verify that everything is working correctly:
```
bundle exec rspec
```

To run the app in a local server:
```
bin/rails server
```

In short:  

* Users can create discussions
* Users can add posts in discussions
* CRUD actions are in realtime (for example when a user updates a discussion, it updates for all users in realtime)
* There are categories
* Users can subscribe or unsubscribe for notifications
* Admin persona

... and more. Feel free to explore 😉