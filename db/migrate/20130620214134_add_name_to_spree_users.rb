class AddNameToSpreeUsers < ActiveRecord::Migration
  def up
  	change_table :spree_users do |t|
  		t.string :first_name
  		t.string :last_name
	end
  end
  def down
  	  	change_table :spree_users do |t|
  		t.remove :first_name
  		t.remove :last_name
	end
  end
end
