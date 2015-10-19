class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :blob, null: false
      t.string :name, null: false, default: ''
      t.text :content, null: false, default: ''
      t.references :wiki, index: true, foreign_key: true

      t.timestamps null: false
    end

    add_index :pages, %i(blob wiki_id), unique: true
  end
end
