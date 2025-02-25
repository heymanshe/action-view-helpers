class AddAuthorToArticles < ActiveRecord::Migration[8.0]
  def change
    add_column :articles, :author_name, :string
  end
end
