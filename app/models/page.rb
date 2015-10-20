class Page < ActiveRecord::Base
  belongs_to :wiki, required: true

  RESERVED_BLOBS = %w(index new).freeze

  validates :blob, presence: true, length: { maximum: 255 }, uniqueness: { scope: %i(wiki_id) },
    exclusion: { in: RESERVED_BLOBS }
  validates :name, presence: true, length: { maximum: 255 }
  validates :content, presence: true

  scope :top, -> { where(blob: 'welcome') }

  class << self
    def urlnize(value)
      return unless value

      # 0-9, a-z, A-Z, - 以外はすべて `_` にする
      value.gsub(/[^[0-9a-zA-Z\-]]/, ?_)
    end

    def welcome
      find_by!(blob: 'welcome')
    end
  end

  def to_param
    blob
  end

  def blob=(value)
    super(self.class.urlnize(value))
  end
end
