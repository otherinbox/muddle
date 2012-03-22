# Muddle

Email clients are not web browsers. They render html all funny, to put it
politely. In general, the best practices for writing HTML that will look good
in an email are the exact inverse from those that you should use for a web
page. Remembering all those differences sucks.

With muddle, we're trying to make it so that the only thing you have to know is
to *use tables in your emails*. Muddle will take care of the rest. It uses
ideas from [HTML Email Boilerplate](http://htmlemailboilerplate.com/) to help
you get your emails in line without having to know tons about how clients
render it.

## Installation

Add this line to your application's Gemfile:

    gem 'muddle'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install muddle

## Usage

Muddle provides the `muddled_layout` helper to quickly set up your email layout
with all the right stuff. Call this in a view or layout and it will insert the
doctype, basic html structure and then yield to the following contexts:

* `title` yields inside the title tag
* `head` yields inside the head tag after the boilerplate style declaration
* `inside_table` yields inside the wrapping table

Code example:

``` erb
<% content_for :title do %>
  The bestest email evar!
<% end %>

<% content_for :head do %>
  <%= stylesheet_link_tag :my_prettiness %>
<% end %>

<% content_for :inside_table do %>
  <table><tr>
    <td>This is how composing email SHOULD work</td>
  </tr></table>
<% end %>

<%= muddled_layout %>
```

You can use the layout helper or not - it's up to you.  Whatever you choose,
you're now free to build email views as you would any other, all you have to do
is stick `.muddle` in the view filename.  When your view is rendered, we'll
make it work:

* CSS will be inlined using premailer, so you can use `stylesheet_link_tag` as
  you normally would
* HTML elements will be augmented with all the attributes they need for email,
  so you don't need to worry about ensuring all your anchor tags have `_target`
  set, etc.
* The resulting schema will be checked for tags that don't play well in email
  (like `div`)

For example, if you want to write your views in haml, name your file
`bacon.html.email.haml` and you're good to go.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
