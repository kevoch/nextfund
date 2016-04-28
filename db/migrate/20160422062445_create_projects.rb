class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer :user_id
      t.string :campaign_title
      t.json :images
      t.string :category
      t.string :address
      t.date :deadline
      t.string :video
      t.string :summary
      t.integer :amount_needed
      t.integer :amount_achieved

      t.timestamps null: false
    end
  end
end
