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
  so you don't need to worry about ensuring all your anchor tags have `_target`
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

### The Basics

#### Rails

When you `require 'muddle/rails'`, Muddle will intercept all email you send,
pull the html body out, run it through the muddler and replace that body with
new, more muddled html. This will happen to all emails automatically without
you having to do a thing.

#### Not Rails

However you're sending email, you'll want to get what you intend to be the html
body of your email into a variable. How you do that is up to you. Say you have
a [SLIM](http://slim-lang.com) template and you're using
[Mail](https://github.com/mikel/mail) to build and send your emails:

```ruby
require 'muddle'
require 'slim'
require 'mail'

body = Slim::Template('path/to/welcome_email.html.slim').render

# This is really the only thing Muddle is involved in.
muddled_body = Muddle.parse(body)

email = Mail.new do
  to 'some_new_customer@gmail.com'
  from 'welcome@awesome_web_service.com'
  subject 'Welcome!!!!!!!!!!1!!!!one!!!'

  html_part do
    body muddled_body
    content_type 'text/html; charset=UTF-8'
  end
end
```

### Configuration

You will see warning messages when you run your mailer tests when your emails
contain something that's not recommended. You can silence them like so (maybe
throw this in an initializer):

```ruby
Muddle.configure do |config|
  config.silence_warnings = true
end
```

### Writing An Email

For best results, just start writing your email with a table tag and move in
from there. Muddler will handle putting the `xmlns` and `DOCTYPE` and a bunch of
stuff into the `<head>`, then open the `<body>` for you. It will also close
these tags at the end.

For example, if you have a template the ends up like this:

```html
<table>
  <tbody>
    <tr>
      <td><h1>Welcome to our AWESOME NEW WEB SERVICE!</h1></td>
    </tr>
    <tr>
      <td><p>You should come <a href="http://example.com">check us out</a>.</p></td>
    </tr>
  </tbody>
</table>
```

Muddle will spit out this:

```html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <style>
      <!-- ... -->
    </style>
  </head>
  <body>
    <table cellpadding="0" cellspacing="0" border="0" id="backgroundTable">
      <tr>
        <td>
          <table cellpadding="0" cellspacing="0" border="0">
            <tbody>
              <tr>
                <td valign="top"><h1>Welcome to our AWESOME NEW WEB SERVICE!</h1></td>
              </tr>
              <tr>
                <td valign="top"><p>You should come <a href="http://example.com">check us out</a>.</p></td>
              </tr>
            </tbody>
          </table>
        </td>
      </tr>
    </table>
  </body>
</html>
```

... Or whatever the output would really be that we'll paste in here when Muddle
actually produces output.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
