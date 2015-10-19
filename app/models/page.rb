class Page < ActiveRecord::Base
  belongs_to :wiki, required: true

  validates :blob, presence: true, length: { maximum: 255 }, uniqueness: { scope: %i(wiki_id) }
  validates :name, presence: true, length: { maximum: 255 }
  validates :content, presence: true
end
