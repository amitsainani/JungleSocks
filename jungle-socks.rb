# filename: jungle-socks.rb

require 'selenium-webdriver'
require 'rspec/expectations'
extend RSpec::Matchers

describe 'JungleSocks' do
  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
  end

  after(:each) do
    @driver.quit
  end

  it 'succeeded' do
    @driver.get 'https://jungle-socks.herokuapp.com'

    expect(@driver.title).to eql 'JungleSocks'

    expect(@driver.find_element(css: 'h1').text).to eql 'Welcome To Jungle Socks!'

    expect(@driver.find_element(css: 'p').text).to eql 'Please enter the quantiy of each kind of sock and then click the checkout button'

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
    # puts states.text
    states.click if states.text == 'California'
    end

    element = @driver.find_element(name: 'commit').submit

    expect(@driver.find_element(css: 'h1').text).to eql 'Please Confirm Your Order'

    element = @driver.find_element(id: 'subtotal')
    element = element.text
    element.gsub!('$','')
    element = element.to_f
    # puts element
    subtotal = 5*13.00 + 0*20.00 + 3*35.00 + 5*17.00
    expect(element).to eql subtotal.to_f
  end
end