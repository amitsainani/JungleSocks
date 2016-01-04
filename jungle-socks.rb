# filename: jungle-socks.rb

require 'selenium-webdriver'
require 'rspec/expectations'
include RSpec::Matchers

def setup
  @driver = Selenium::WebDriver.for :firefox
end

def teardown
  @driver.quit
end

def run
  setup
  yield
  teardown
end

run do
  @driver.get 'https://jungle-socks.herokuapp.com'

  expect(@driver.title).to eql 'JungleSocks'

  h1 = @driver.find_element(css: 'h1')
  expect(h1.text).to eql 'Welcome To Jungle Socks!'

  p = @driver.find_element(css: 'p')
  expect(p.text).to eql 'Please enter the quantiy of each kind of sock and then click the checkout button'
  
  def quantity(zebra, lion, elephant, giraffe)
  	element = @driver.find_element(id: 'line_item_quantity_zebra').send_keys zebra
  	element = @driver.find_element(id: 'line_item_quantity_lion').send_keys lion
  	element = @driver.find_element(id: 'line_item_quantity_elephant').send_keys elephant
  	element = @driver.find_element(id: 'line_item_quantity_giraffe').send_keys giraffe
  end

  quantity(5, 0, 3, 5)

  ship_to_state = @driver.find_element(name: 'state')
  options = ship_to_state.find_elements(tag_name: 'option')
  options.each do |states|
#  puts states.text
  states.click if states.text == 'California'
  end

  element = @driver.find_element(name: 'commit').click

  h1 = @driver.find_element(css: 'h1')
  expect(h1.text).to eql 'Please Confirm Your Order'

  element = @driver.find_element(id: 'subtotal')
  expect(element.text).to eql 5*13.00 + 0*20.00 + 3*35.00 + 5*17.00
end