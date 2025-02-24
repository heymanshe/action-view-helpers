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




