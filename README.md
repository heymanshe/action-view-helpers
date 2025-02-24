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



