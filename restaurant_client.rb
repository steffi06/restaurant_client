# Build a command line client (a Ruby program) that consumes the API. 
# You only have to make methods to be able to list all the Customers and to create a new Customer.

require 'addressable/uri'
require 'open-uri'
require 'json'
require 'rest_client'
require 'rubygems'
require 'highline/import'

# Client...

HOST = "localhost:3000"

def list_customers
  RestClient.get(Addressable::URI.new({
    :scheme => "http",
    :host => HOST,
    :path => "/customers.json"
  }).to_s)
end

def create_customer(first_name, last_name)
  RestClient.post(Addressable::URI.new({
    :scheme => "http",
    :host => HOST,
    :path => "/customers.json"
  }).to_s, {
    :customer => {
      :first_name => first_name,
      :last_name => last_name
    }
  })
end


# Implementation of client...

def request_user_input_customer_info
  @first_name = ask "Input Start Location: "
end

def interact_with_user
  p 'Choose to List Customers or Create New Customer'
  customer_access = ask "Type 'l' for list or 'c' for create: "
  if customer_access == 'l'
    list_customers
  elsif customer_access == 'c'
    p 'You chose to create a new customer.'
    first_name = ask "First name of customer:"
    last_name = ask "Last name of customer:"
    create_customer(first_name, last_name)
    list_customers
  else 
    p "Invalid choice."
  end
end

interact_with_user


