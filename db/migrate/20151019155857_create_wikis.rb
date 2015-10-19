class CreateWikis < ActiveRecord::Migration
  def change
    create_table :wikis do |t|
      t.string :blob, null: false
      t.string :name, null: false, default: ''

      t.timestamps null: false
    end

    add_index :wikis, :blob, unique: true
  end
end
