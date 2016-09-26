class AddScoresToWebsites < ActiveRecord::Migration[5.0]
  def change
    add_column :websites, :mobile_score, :integer
    add_column :websites, :desktop_score, :integer
  end
end
