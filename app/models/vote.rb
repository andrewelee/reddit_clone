class Vote < ActiveRecord::Base
  validates :voteable, presence: true

  belongs_to :voteable, polymorphic: true

end