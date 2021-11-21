class ApplicationMailer < ActionMailer::Base
  default from: 'tester@test.com'
  layout 'mailer'
end
