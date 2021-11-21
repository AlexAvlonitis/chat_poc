# CHAT POC

Chat prototype, using action cable.

Created Unit tests, but not integration, acceptance tests.

The chat DB schema includes a: room -> messages <- user, on a sqlite DB.

The user authentication uses the devise gem but not the confirmable feature in order to validate the email. Authenticated users can only access the chat pages.

Minimal CSS has been implemented.

For background processing I used the Rails's memory store and not persistent storage such as sidekiq with redis.

For the weekly emails i created a rake task and used the whenever gem to create cronjobs in an easy way.

Code does't have a lot of abstractions such as service objects etc... i used mostly the MVC objects since there is not a lot of code.


**How to run**
```ruby
bundle install

rails db:setup
rails s
# visit http://localhost:3000

# Run tests
rspec

# Run the weekly task manually
rake weekly:email_report

# If you want to test real emails
# Install mailcatcher gem locally https://mailcatcher.me/
# And run the rake task again to see them live.

# To set the cronjob on the machine run
crontab -l # to list current cronjobs
bundle exec whenever --update-crontab
crontab -l # to see if the new one is there
```


