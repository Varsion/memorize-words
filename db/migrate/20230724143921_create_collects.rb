class CreateCollects < ActiveRecord::Migration[7.0]
  def change
    create_table :collects do |t|
      t.belongs_to :user
      t.belongs_to :glossary
      t.timestamps
    end
  end
end
