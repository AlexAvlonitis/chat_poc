# To avoid installing sidekiq and redis for local dev and POC
# I have used the deliver_now(synchronous) requests of the mailer jobs
# because Jobs from rake tasks cannot run asyncronously without a persistent queue
# (NOTE) https://edgeguides.rubyonrails.org/active_job_basics.html#action-mailer

namespace :weekly do
  desc 'Emails weekly message reports to all users'
  task email_report: [ :environment ] do
    room = Room.find_by(name: Room::MAIN_ROOM_NAME)
    message_total_count = room.last_weeks_messages_count
    users = User.includes(:messages).all

    users.each do |user|
      puts 'Sending Total Weekly Messsages ...'
      WeeklyMessagesTotalMailer
        .report(user: user, messages_total: message_total_count)
        .deliver_now

      puts 'Sending User Total Weekly Messsages ...'
      message_user_total_count = room.last_weeks_messages_count(user.last_message_date)
      WeeklyMessagesUserMailer
        .report(user: user, messages_user: message_user_total_count)
        .deliver_now
    end
  end
end
