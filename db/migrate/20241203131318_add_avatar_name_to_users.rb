class AddAvatarNameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :avatar_name, :string
  end
end
