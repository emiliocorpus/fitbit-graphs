class CreateDemos < ActiveRecord::Migration
  def change
    create_table :demos do |t|
      t.text :data

      t.timestamps null: false
    end
  end
end
