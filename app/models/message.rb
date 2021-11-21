class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  def short_date
    created_at.to_formatted_s(:short)
  end

  def to_hash
    {
      content: content,
      short_date: short_date
    }
  end
end
