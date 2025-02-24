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


