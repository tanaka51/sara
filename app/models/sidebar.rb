class Sidebar < ActiveRecord::Base
  belongs_to :wiki, required: true

  validates :content, presence: true
end
