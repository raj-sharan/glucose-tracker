class SeedRole < ActiveRecord::Migration
  def change
  	["Doctor","Patient"].each do |type|
  		Role.create(:name => type) unless Role.exists?(:name => type)
  	end
  end
end
