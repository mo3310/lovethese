class Post < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps
  has_many :post_comments, dependent: :destroy

  def save_tag(sent_tags)
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.post_tags.delete PostTag.find_by(tag_name: old)
    end

    new_tags.each do |new|
      new_post_tag = PostTag.find_or_create_by(tag_name: new)
      self.post_tags << new_post_tag
    end
  end

end
