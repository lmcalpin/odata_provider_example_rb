class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :todo

      t.timestamps
    end
  end
end
