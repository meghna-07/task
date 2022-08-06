class Project < ApplicationRecord
  has_many :tasks
  belongs_to :user
  validates :name, presence: true, length: { minimum: 6, maximum: 100 }
  validates :description, presence: true, length: { maximum: 300 }
  def badge_color
    case status
    when 'not-started'
      'secondary'
    when 'in-progress'
      'info'
    when 'complete'
      'success'
    end
  end

  def status
    return 'not-started' if tasks.none?

    if tasks.all? { |task| task.complete? }
      'complete'
    elsif tasks.any? { |task| task.in_progress? || task.complete? }
      'in-progress'
    else
      'not-started'
    end
  end
end
