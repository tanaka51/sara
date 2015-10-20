class CreateSidebars < ActiveRecord::Migration
  def change
    create_table :sidebars do |t|
      t.references :wiki, index: true, foreign_key: true
      t.text :content, null: false, default: ''

      t.timestamps null: false
    end
  end
end
