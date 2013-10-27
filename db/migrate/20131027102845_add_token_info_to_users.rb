class AddTokenInfoToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :access_token
      t.string :refresh_token
      t.integer :expires_at, default: nil
    end
  end
end
