require "sinatra"
require 'sendgrid-ruby'
include SendGrid
get "/" do
  erb :home
end

get "/cars-page" do
  erb :cars_page
end

get "/auto-services" do
  erb :auto_services
end

get "/contact-us" do
  erb :contact_us
end

post "/contact-us-response" do
  from = SendGrid::Email.new(email: params[:from])
  subject = params[:subject]
  to = SendGrid::Email.new(email: params[:to])
  content = SendGrid::Content.new(type: 'text/plain', value: params[:content])
  mail = SendGrid::Mail.new(from, subject, to, content)
  sg = SendGrid::API.new(api_key: "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")
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  redirect "/contact-us"
 end
