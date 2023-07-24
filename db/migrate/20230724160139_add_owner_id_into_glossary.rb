class AddOwnerIdIntoGlossary < ActiveRecord::Migration[7.0]
  def change
    add_column :glossaries, :owner_id, :integer
  end
end
