# filename: spec/junglesocks_spec.rb

require 'selenium-webdriver'
require 'rspec/expectations'
extend RSpec::Matchers
require_relative '../pages/junglesocks'
require_relative 'spec_helper'

describe 'JungleSocks' do

  before(:each) do
    @driver = Selenium::WebDriver.for :firefox
    @junglesocks = JungleSocks.new(@driver)
  end

  after(:each) do
    @driver.quit
  end

  it 'succeeded' do
    @junglesocks.quantity(5, 0, 3, 5)

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