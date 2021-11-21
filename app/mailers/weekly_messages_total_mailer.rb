class WeeklyMessagesTotalMailer < ApplicationMailer
  def report(user, messages_total)
    @user = user
    @messages_total = messages_total
    mail(to: @user.email, subject: 'Weekly messages in total')
  end
end
