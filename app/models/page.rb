class Page < ActiveRecord::Base
  belongs_to :wiki, required: true

  RESERVED_BLOBS = %w(new).freeze

  validates :blob, presence: true, length: { maximum: 255 }, uniqueness: { scope: %i(wiki_id) },
    exclusion: { in: RESERVED_BLOBS }
  validates :name, presence: true, length: { maximum: 255 }
  validates :content, presence: true

  def to_param
    blob
  end

  def blob=(value)
    # 0-9, a-z, A-Z, - 以外はすべて `_` にする
    super(value.try(:gsub, /[^[0-9a-zA-Z\-]]/, ?_))
  end
end
