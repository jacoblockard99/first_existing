# FirstExisting

FirstExisting is an extremely simple Ruby gem that contains methods for selecting objects based on their existence.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'first_existing'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install first_existing

## Usage

FirstExisting is currently composed of only 3 methods: `first_existing`, `Hash#required!`, and `Hash#default!`

### `first_existing`

`first_existing` accepts list of objects, returning that first that is not `nil`. It is automatically added globally to `Kernel`. Example:

```ruby
first_existing(nil, nil, "test", nil) # => "test"
```

A common use case for it is with Ruby on Rails content helpers, like so:

```erb
<head>
  <title><%= first_existing(content_for(:title), "default") %></title>
</head>
```

 ### `Hash#required!`
 
 FirstExisting also automatically adds a `required!` method to `Hash` that automatically raises exceptions when the given key does not exist. For example:
 
 ```ruby
 def some_method(options = {})
   options.required! :name
   "Hello, #{name}"
 end
 
 some_method(name: "Jacob") # => "Hello, Jacob"
 some_method(last_name: "Lockard") # => RuntimeError (The 'name' option is required!)
 ```

### `Hash#default!`

Finally, a `default!` method is added to `Hash` that automatically sets defaults for a key if its value is nil. It accepts as parameters the name of the key to change and a list of default values. The first existing value is used. For example:

```ruby
$GLOBAL_LAST_NAME = "Global"
class Example
    def initialize(last_name:)
      @last_name = last_name
    end

    def some_method(options = {})
      options.default! :name, "Jacob"
      options.default! :last_name, $GLOBAL_LAST_NAME, @last_name, "Lockard"
      "Hello, #{options[:name]} #{options[:last_name]}"
    end
end

Example.new(last_name: "Class").some_method(last_name: "Last") # => "Hello, Jacob Last"

Example.new(last_name: "Class").some_method(name: "First") # => "Hello, First Global"

$GLOBAL_LAST_NAME = nil
Example.new(last_name: "Class").some_method # => "Hello, Jacob Class"

Example.new(last_name: nil).some_method # => "Hello, Jacob Lockard"
```
