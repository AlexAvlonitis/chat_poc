class WeeklyMessagesUserMailer < ApplicationMailer
  def report(user, messages_user)
    @user = user
    @messages_user = messages_user
    mail(to: @user.email, subject: 'Weekly messages since your last message')
  end
end
