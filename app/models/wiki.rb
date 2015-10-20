class Wiki < ActiveRecord::Base
  has_many :pages, dependent: :destroy

  has_one :sidebar

  validates :blob, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :name, presence: true, length: { maximum: 255 }

  after_create :create_welcome_page

  def to_param
    blob
  end

  private

  def create_welcome_page
    pages.create(
      blob: 'welcome',
      name: 'Welcome',
      content: <<MARKDOWN
# Welcome!!
新しい wiki がつくられました!
おめでとうございます!!

このページは常にトップとして表示されます。
お好きなように編集してください。

以下にお役立ち情報を載せますので、ご活用ください(TODO):
- 書式について(markdown)
- 絵文字
MARKDOWN
    )
  end
end
