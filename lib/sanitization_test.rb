require "action_view"

include ActionView::Helpers::SanitizeHelper

html_content = "<b>Bold</b> and <i>italic</i> and <script>alert('XSS');</script>"
css_content = "background-color: red; color: white; font-size: 16px; position: absolute;"
html_with_links = "Visit <a href='https://rubyonrails.org'>Ruby on Rails</a> now!"
html_with_tags = "<h1>Header</h1><p>Paragraph <b>bold</b></p>"

puts "Sanitize Example:"
puts sanitize(html_content)
puts sanitize(html_content, tags: %w[b i], attributes: %w[id class])
puts "----------------------------"

puts "Sanitize CSS Example:"
puts sanitize_css(css_content)
puts "----------------------------"

puts "Strip Links Example:"
puts strip_links(html_with_links)
puts "----------------------------"

puts "Strip Tags Example:"
puts strip_tags(html_with_tags)
puts "----------------------------"
