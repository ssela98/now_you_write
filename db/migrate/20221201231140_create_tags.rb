# frozen_string_literal: true

class CreateTags < ActiveRecord::Migration[7.0]
  def up
    create_table :tags, if_not_exists: true do |t|
      t.string :name, unique: true, limit: 24

      t.timestamps
    end

    add_index :tags, :name, unique: true, if_not_exists: true
  end

  def down
    drop_table :tags, if_exists: true
  end
end
