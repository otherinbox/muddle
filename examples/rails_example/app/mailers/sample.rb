class Sample < ActionMailer::Base
  default :from => "from@example.com"

  def example
    mail(:to => 'user@domain.com', :subject => 'this is an email')
  end
end
