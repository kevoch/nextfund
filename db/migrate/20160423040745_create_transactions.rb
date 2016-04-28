class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
    	t.string :braintree_transaction_id
    	t.decimal :amount
    	t.string :status
    	t.string :last_4
    	t.integer :user_id
    	t.integer :project_id

      t.timestamps null: false
    end
  end
end
