# Muddle Rails Example

This is an example of using muddle with rails.  To get started, just install the
environment:

    bundle

Fire up a console

    bundle exec rails console

And check out the result of the email view `app/views/sample/example.html`

    puts Sample.example.deliver.body


# How did this happen?

This app was created using as a generic new rails project.  A mailer named `Sample` 
was created using the generator:

    rails g mailer Sample

A method named `example` was added to the mailer

``` ruby
# app/mailers/sample.rb

def example
  mail(:to => 'user@domain.com', :subject => 'this is an email')
end
```

A view was created using vanilla HTML:

``` html
<!-- app/views/sample/example.html -->

<html>
  <body>
    <table>
      <tbody>
        <tr>
          <td><h1>Welcome to our AWESOME NEW WEB SERVICE!</h1></td>
        </tr>
        <tr>
          <td><p>You should <a href="http://example.com">check us out</a>.</p></td>
        </tr>
      </tbody>
    </table>
  </body>
</html>
```

and `muddle` was added to the Gemfile

    gem 'muddle', :require => 'muddle/rails'

Easy peasy!
