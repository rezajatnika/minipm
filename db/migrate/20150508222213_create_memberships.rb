class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :project, index: true
      t.references :member, index: true

      t.timestamps null: false
    end
  end
end
