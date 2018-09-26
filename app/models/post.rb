class Post < ActiveRecord::Base

  validates :title,  presence: true
  validates :content, length: { minimum: 250 }
  validates :summary, length: { maximum: 250 }
  validates :category, inclusion: { in: %w(Fiction Non-Fiction) }

  validate :is_clickbait?

#  Patterns to look out for - better defined outside of the method

  CLICKBAIT_PATTERNS = [
    /Won't Believe/i,
    /Secret/i,
    /Top [0-9]*/i,    # any number 
    /Guess/i
  ]

  def is_clickbait?
    if CLICKBAIT_PATTERNS.none? { |pattern| pattern.match title }
      errors.add(:title, "must be clickbait BIYATCH!")
      #  errors.add  - is a validation each method (attr, text you want to display) - 2.13 validates_each
      #  https://guides.rubyonrails.org/active_record_validations.html#inclusion
    end
  end



end
