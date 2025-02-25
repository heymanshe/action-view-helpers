atom_feed do |feed|
  feed.title("Articles Feed")
  feed.updated(@articles.maximum(:created_at) || Time.zone.now)

  @articles.each do |article|
    feed.entry(article) do |entry|
      entry.title(article.title)
      entry.content(article.content, type: "html")

      entry.author do |author|
        author.name(article.author_name)  # Ensure this is included
      end
    end
  end
end
