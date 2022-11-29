class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: { minimum: 250 }
    validates :summary, length: { maximum: 250 }
    validates :category, inclusion: { in: %w(Fiction Non-Fiction) }
    validate :click_bait, on: :create

    def click_bait
        if TITLE_CLICK_BAIT.none? { |s| s.match title }
            errors.add :title, "Not enough click bait!"
        end
    end

    private
    TITLE_CLICK_BAIT = [
        /Won't Believe/i, 
        /Secret/i, 
        /Top\d/i, 
        /Guess/i
    ]

end
