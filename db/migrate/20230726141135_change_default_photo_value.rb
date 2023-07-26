class ChangeDefaultPhotoValue < ActiveRecord::Migration[7.0]
  def up
    change_column_default :users, :photo, 'https://cdn-icons-png.flaticon.com/512/149/149071.png'
  end

  def down
    change_column_default :users, :photo, nil
  end
end
