class Wiki < ActiveRecord::Base
  has_many :pages, dependent: :destroy

  validates :blob, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :name, presence: true, length: { maximum: 255 }

  def to_param
    blob
  end
end
