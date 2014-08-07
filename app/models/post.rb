class Post < ActiveRecord::Base

  validates :title, :author_id, presence: true

  has_many(
    :post_subs,
    class_name: "PostSub",
    foreign_key: :post_id,
    primary_key: :id,
    inverse_of: :post
  )

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :top_level_comments,
    -> { where("parent_comment_id IS NULL") }, as: :commentable,
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id
  )

  has_many :subs, through: :post_subs, source: :sub

  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :post_id,
    primary_key: :id
  )

  has_many :votes, as: :voteable

  def comments_by_parent_id
    result = Hash.new {|hash, key| hash[key] = []}
    self.comments.each do |comment|
      result[comment.parent_comment_id] << comment
    end
    result
  end

  def karma
    karma = 0
    self.votes.each do |vote|
      karma += vote.value
    end
    karma
  end

end