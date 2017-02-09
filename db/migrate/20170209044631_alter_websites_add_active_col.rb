class AlterWebsitesAddActiveCol < ActiveRecord::Migration[5.0]
  def change
    add_column :websites, :active, :boolean, default: true
  end
end
