# Muddle

Email clients are not web browsers. They render html all funny, to put it
politely. In general, the best practices for writing HTML that will look good
in an email are the exact inverse from those that you should use for a web
page. Remembering all those differences sucks.

With muddle, we're trying to make it so that the only thing you have to know is
to **use tables in your emails**. Muddle will take care of the rest. It uses
ideas from [HTML Email Boilerplate](http://htmlemailboilerplate.com/) to help
you get your emails in line without having to know tons about how clients
render it.

* CSS will be inlined using premailer, so you can use external style sheets as
  you normally would.
* HTML elements will be augmented with all the attributes they need for email,
  so you don't need to worry about ensuring all your anchor tags have `\_target`
  set, etc.
* The resulting html document will be checked for tags that don't play well in
  email (like `div`).

## Installation

### Rails

In your `Gemfile`:

    gem 'muddle', require: 'muddle/rails'

And then execute:

    $ bundle

### Not Rails

Add this line to your application's `Gemfile`:

    gem 'muddle'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install muddle

## Usage

### Rails

When you `require 'muddle/rails'`, Muddle will intercept all email you send,
pull the html body out, run it through the muddler and replace that body with
new, more muddled html. This will happen to all emails automatically without
you having to do a thing.

You will see warning messages when you run your mailer tests when your emails
contain something that's not recommended. You can silence them like so (maybe
throw this in an initializer):

```ruby
Muddle.configure do |config|
  config.silence_warnings = true
end
```

### Not Rails

However you're sending email, you'll want to get what you intend to be the html
body of your email into a variable. How you do that is up to you. Then you want
to pass that body to Muddle:

```ruby
muddled_body = Muddle.parse(body)
```

Then used the newly muddled body as the html body of your email and send it.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
