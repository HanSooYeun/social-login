class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.references :user, index: true, foreign_key: true
      t.string :uid
      t.string :provider
      t.boolean :registered

      t.timestamps null: false
    end
  end
end
