class Post < ActiveRecord::Base

  validates :title, :sub_id, :author_id, presence: true

  has_many(
    :sub_posts,
    class_name: "PostSub",
    foreign_key: :post_id,
    primary_key: :id
  )

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many :subs, through: :sub_posts, source: :sub

end