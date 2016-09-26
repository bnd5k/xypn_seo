class CreateWebsites < ActiveRecord::Migration[5.0]
  def change
    create_table :websites do |t|
      t.string      :url
      t.string      :business
      t.string      :advisor
      t.string      :xypn_profile
      
      t.timestamps
    end
  end
end
