class CreateQueues < ActiveRecord::Migration[6.1]
  def change
    create_table :queues do |t|
      t.string :name
      t.timestamps
    end
  end
end