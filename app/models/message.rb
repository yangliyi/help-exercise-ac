class Message < ActiveRecord::Base

  belongs_to :user

  has_many :comments, :dependent => :destroy

  scope :pending, -> { where( :status => "pending" ) }
  scope :completed, -> { where( :status => "completed" ) }

  def self.within_days(t=Time.now)
      where(["created_at > ? ", t ])
  end



  def last_comment_summary
    self.comments.last.try(:content).try(:truncate, 20)
  end

end
