# 1. Formatting Helpers

## 1.1 Dates

- Rails provides helpers to display date and time elements in a human-readable format.

### 1.1.1 distance_of_time_in_words

- Calculates the approximate time difference between two `Time` or `Date` objects (or integers as seconds).

- Use `include_seconds`: true for more detailed approximations.

```ruby
distance_of_time_in_words(Time.current, 15.seconds.from_now)
# => "less than a minute"

distance_of_time_in_words(Time.current, 15.seconds.from_now, include_seconds: true)
# => "less than 20 seconds"
```

- `Time.current` is preferred over `Time.now` as it respects the Rails-configured timezone.


### 1.1.2 time_ago_in_words

- Calculates the approximate time difference between a given Time or Date object (or integer in seconds) and Time.current.

```ruby
time_ago_in_words(3.minutes.from_now)
# => "3 minutes"
```

## 1.2 Number Formatting Methods 

- A set of methods for converting numbers into formatted strings.

### 1.2.1 number_to_currency

- Formats a number into a currency string.

```ruby
number_to_currency(1234567890.50) # => $1,234,567,890.50
```

### 1.2.2 number_to_human

- Formats large numbers into a more readable form.

```ruby
number_to_human(1234)    # => 1.23 Thousand
number_to_human(1234567) # => 1.23 Million
```

### 1.2.3 number_to_human_size

- Formats bytes into a human-readable file size.

```ruby
number_to_human_size(1234)    # => 1.21 KB
number_to_human_size(1234567) # => 1.18 MB
```

### 1.2.4 number_to_percentage

- Formats a number as a percentage string.

```ruby
number_to_percentage(100, precision: 0) # => 100%
```

### 1.2.5 number_to_phone

- Formats a number into a phone number format (US default).

```ruby
number_to_phone(1235551234) # => 123-555-1234
```

### 1.2.6 number_with_delimiter

- Formats a number with grouped thousands using a delimiter.

```ruby
number_with_delimiter(12345678) # => 12,345,678
```

### 1.2.7 number_with_precision

- Formats a number with a specified level of precision (default: 3).

```ruby
number_with_precision(111.2345)               # => 111.235
number_with_precision(111.2345, precision: 2) # => 111.23
```

## 1.3 Text

- A set of methods for filtering, formatting, and transforming strings.

### 1.3.1 excerpt

- Extracts the first occurrence of a phrase with surrounding text based on a radius.

- Adds omission markers if the extracted text doesn't align with the original text's start or end.

- Example:

```ruby
excerpt("This is a very beautiful morning", "very", separator: " ", radius: 1)
# => ...a very beautiful...
```

### 1.3.2 pluralize

- Returns singular or plural form of a word based on a number.

- Custom plural forms can be provided.

- Example:

```ruby
pluralize(1, "person") # => 1 person
pluralize(2, "person") # => 2 people
pluralize(3, "person", plural: "users") # => 3 users
```

### 1.3.3 truncate

- Truncates text to a specified length.

- Adds an omission marker if truncation occurs.

- Can specify a separator and omission text.

- Example:

```ruby
truncate("Once upon a time in a world far far away")
# => "Once upon a time in a world..."
```

### 1.3.4 word_wrap

- Wraps text into lines not exceeding a specified width.

- Example:

```ruby
word_wrap("Once upon a time", line_width: 8)
# => "Once\nupon a\ntime"
```

# 2. Form Helpers

- Form helpers simplify working with models compared to standard HTML elements. They provide various methods to generate forms efficiently based on models.

- **Key Benefits**

  - **Simplifies Form Creation**: Provides predefined methods for different input types.

  - **Model Integration**: Generates forms directly tied to models.

  - **Automatic Parameter Handling**: Form inputs are grouped into the params object and sent to the controller on submission.

- **Common Form Helper Methods**

  - Text Fields (text_field)

  - Password Fields (password_field)

  - Select Dropdowns (select)

  - Check Boxes & Radio Buttons (check_box, radio_button)

# 3. Navigation Methods

## 3.1 button_to

- Generates a form with a submit button linking to a specified URL.

```ruby
<%= button_to "Sign in", sign_in_path %>
```

- Output:

```ruby
<form method="post" action="/sessions" class="button_to">
  <input type="submit" value="Sign in" />
</form>
```

## 3.2 current_page?

- Returns true if the current request URL matches the given options.

```ruby
<% if current_page?(controller: 'profiles', action: 'show') %>
  <strong>Currently on the profile page</strong>
<% end %>
```

## 3.3 link_to

- Creates an anchor tag linking to a specified URL or model.

```ruby
<%= link_to "Profile", @profile %>
<!-- Output: <a href="/profiles/1">Profile</a> -->

<%= link_to "Articles", articles_path, id: "articles", class: "article__container" %>
<!-- Output: <a href="/articles" class="article__container" id="articles">Articles</a> -->
```

- Block usage:

```ruby
<%= link_to @profile do %>
  <strong><%= @profile.name %></strong> -- <span>Check it out!</span>
<% end %>
```

- Output:

```ruby
<a href="/profiles/1">
  <strong>David</strong> -- <span>Check it out!</span>
</a>
```

## 3.4 mail_to

- Generates a mailto link to an email address.

```ruby
<%= mail_to "john_doe@gmail.com" %>
<!-- Output: <a href="mailto:john_doe@gmail.com">john_doe@gmail.com</a> -->

<%= mail_to "me@john_doe.com", cc: "me@jane_doe.com", subject: "Example Email" %>
```

## 3.5 url_for

- Returns the URL for the given model or options.

```ruby
<%= url_for @profile %>
<!-- Output: /profiles/1 -->

<%= url_for [@hotel, @booking, page: 2, line: 3] %>
<!-- Output: /hotels/1/bookings/1?line=3&page=2 -->
```

# 4. Sanitization 

- Rails provides built-in methods for sanitizing text to ensure safe and valid HTML/CSS rendering. These methods help prevent XSS attacks by escaping or removing potentially malicious content. This functionality is powered by the rails-html-sanitizer gem.

## 4.1 sanitize

- Encodes HTML tags and strips attributes unless specifically allowed.

```ruby
sanitize @article.body
```

- Allowing specific tags and attributes:

```ruby
sanitize @article.body, tags: %w(table tr td), attributes: %w(id class style)
```

- To change the defaults globally, modify config/application.rb:

```ruby
class Application < Rails::Application
  config.action_view.sanitized_allowed_tags = %w(table tr td)
end
```

## 4.2 sanitize_css

- Sanitizes a block of CSS code, especially from style attributes in user-generated content.

```ruby
sanitize_css("background-color: red; color: white; font-size: 16px;")
```

## 4.3 strip_links

- Removes all `<a>` tags while keeping the link text.

```ruby
strip_links("<a href='https://rubyonrails.org'>Ruby on Rails</a>")
# => Ruby on Rails

strip_links("emails to <a href='mailto:me@email.com'>me@email.com</a>.")
# => emails to me@email.com.
```

## 4.4 strip_tags

- Removes all HTML tags, including comments and special characters.

```ruby
strip_tags("Strip <i>these</i> tags!")
# => Strip these tags!

strip_tags("<b>Bold</b> no more! <a href='more.html'>See more</a>")
# => Bold no more! See more
```

# 5. Asset Host Configuration

- By default, Rails links to assets in the `public` folder, but you can configure a dedicated asset server using `config.asset_host` in `config/environments/production.rb`:

```ruby
config.asset_host = "assets.example.com"
```

- Then, asset helper methods generate URLs like:

```ruby
image_tag("rails.png")
# => <img src="//assets.example.com/images/rails.png" />
```

**Asset Helper Methods**

## 5.1 audio_tag

- Generates an HTML `<audio>` tag.

```ruby
audio_tag("sound.wav", "sound.mid")
# => <audio><source src="/audios/sound.wav" /><source src="/audios/sound.mid" /></audio>
```

## 5.2  auto_discovery_link_tag

- Creates a link for auto-discovery of RSS, Atom, or JSON feeds.

```ruby
auto_discovery_link_tag(:rss, "http://www.example.com/feed.rss", title: "RSS Feed")
# => <link rel="alternate" type="application/rss+xml" title="RSS Feed" href="http://www.example.com/feed.rss" />
```

## 5.3 favicon_link_tag

- Generates a link tag for the favicon.

```ruby
favicon_link_tag
# => <link href="/assets/favicon.ico" rel="icon" type="image/x-icon" />
```

## 5.4 image_tag

- Generates an `<img>` tag.

```ruby
image_tag("icon.png", size: "16x10", alt: "Edit Article")
# => <img src="/assets/icon.png" width="16" height="10" alt="Edit Article" />
```

## 5.5 javascript_include_tag

- Includes JavaScript files in the page.

```ruby
javascript_include_tag("common", async: true)
# => <script src="/assets/common.js" async="async"></script>
```

## 5.6 picture_tag

- Creates a `<picture>` element with multiple sources.

```ruby
picture_tag("icon.webp", "icon.png")
```

- Generates:

```ruby
<picture>
  <source srcset="/assets/icon.webp" type="image/webp" />
  <source srcset="/assets/icon.png" type="image/png" />
  <img src="/assets/icon.png" />
</picture>
```

## 5.7 preload_link_tag

- Preloads assets for performance optimization.

```ruby
preload_link_tag("application.css")
# => <link rel="preload" href="/assets/application.css" as="style" type="text/css" />
```

## 5.8 stylesheet_link_tag

- Includes CSS stylesheets in the page.

```ruby
stylesheet_link_tag("application", media: "all")
# => <link href="/assets/application.css" media="all" rel="stylesheet" />
```

## 5.9 video_tag

- Generates an HTML `<video>` tag.

```ruby
video_tag(["trailer.ogg", "trailer.flv"])
# => <video><source src="/videos/trailer.ogg" /><source src="/videos/trailer.flv" /></video>
```

# 6. Javascript

## 6.1 escape_javascript

- Escapes carriage returns, single quotes, and double quotes in JavaScript segments.

- Ensures text does not contain invalid characters when parsed by the browser.

- Useful when rendering dynamic text inside JavaScript.

```ruby
<%# app/views/users/greeting.html.erb %>
My name is <%= current_user.name %>, and I'm here to say "Welcome to our website!"

<script>
  var greeting = "<%= escape_javascript render('users/greeting') %>";
  alert(`Hello, ${greeting}`);
</script>
```

- Correctly escapes quotes to display the greeting in an alert box.

## 6.2 javascript_tag

- Wraps provided JavaScript code inside a `<script>` tag.

- Accepts a hash of options to control script tag attributes.

```ruby
<%= javascript_tag("alert('All is good')", type: "application/javascript") %>
```

```
<script type="application/javascript">
//<![CDATA[
alert('All is good')
//]]>
</script>
```

- Alternatively, use a block:

```ruby
<%= javascript_tag type: "application/javascript" do %>
  alert("Welcome to my app!")
<% end %>
```

# 7. Alternative HTML Tag Helpers

## 7.1 `tag`

Generates a standalone HTML tag with the given name and options.

### Syntax:
```ruby
tag.some_tag_name(optional content, options)
```
- Supports any tag (e.g., `br`, `div`, `section`, `article`).
- Adds optional attributes via `options`.

### Examples:
```ruby
tag.h1 "All titles fit to print"
# => <h1>All titles fit to print</h1>

tag.div "Hello, world!"
# => <div>Hello, world!</div>

tag.section class: %w(kitties puppies)
# => <section class="kitties puppies"></section>

tag.div data: { user_id: 123 }
# => <div data-user-id="123"></div>
```
- **`data` attributes**: Passed as a hash, converted to `data-*` attributes for JavaScript compatibility.

## 7.2 `token_list`

Generates a string of tokens from the provided arguments. 

- **Alias:** `class_names`

- Filters out falsy values like `nil`, `false`, and empty strings.

### Examples:

```ruby
token_list("cats", "dogs")
# => "cats dogs"

token_list(nil, false, 123, "", "foo", { bar: true })
# => "123 foo bar"

mobile, alignment = true, "center"
token_list("flex items-#{alignment}", "flex-col": mobile)
# => "flex items-center flex-col"

class_names("flex items-#{alignment}", "flex-col": mobile)
# => "flex items-center flex-col"
```

# 8. Capture Blocks 

- Capture blocks in Rails allow you to extract and reuse generated markup in templates or layouts. This is done using `capture` and `content_for` methods.

## 8.1 capture

- Extracts part of a template into a variable.

- Returns the string generated by the block.

- Can be used in templates, layouts, or helpers.

```ruby
<% @greeting = capture do %>
  <p>Welcome! The date and time is <%= Time.current %></p>
<% end %>
```

- This variable can be used anywhere:

```ruby
<html>
  <head>
    <title>Welcome!</title>
  </head>
  <body>
    <%= @greeting %>
  </body>
</html>
```

## 8.2 content_for

- Stores a block of markup in an identifier for later use.

- Used to dynamically insert content into layouts.

- Can be called multiple times, appending content.

- Cannot be used inside fragment caches.

- Define content in a view:

```ruby
<% content_for(:html_title) { "Special Page Title" } %>
```

- Use it in a layout:

```ruby
<html>
  <head>
    <title><%= content_for?(:html_title) ? yield(:html_title) : "Default Title" %></title>
  </head>
</html>
```

# 9. Benchmarking

## 9.1 Using benchmark

- Wrap a benchmark block around expensive operations or possible bottlenecks to measure execution time.

```ruby
<% benchmark "Process data files" do %>
  <%= expensive_files_operation %>
<% end %>
```

- This logs execution time: `Process data files (0.34523)`.

- Available in controllers, helpers, models, etc.

## 9.2 Caching

**Fragment Caching**

- Cache parts of a view instead of an entire page.

- Useful for caching menus, lists, static HTML fragments, etc.

```ruby
<% cache do %>
  <%= render "application/footer" %>
<% end %>
```

**Caching Based on Model Instances**

- Cache each item separately by passing an object to cache.

```ruby
<% @articles.each do |article| %>
  <% cache article do %>
    <%= render article %>
  <% end %>
<% end %>
```

- Generates a unique cache key, e.g.
`:views/articles/index:bea67108094918eeba32cd4a6f786301/articles/1`

