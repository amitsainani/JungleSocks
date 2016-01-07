# filename: pages/junglesocks.rb

class JungleSocks

  def initialize(driver)
    @driver = driver
    @driver.get 'https://jungle-socks.herokuapp.com'
    @driver.title.should == 'JungleSocks'
    @driver.find_element(css: 'h1').text.should == 'Welcome To Jungle Socks!'
    @driver.find_element(css: 'p').text.should == 'Please enter the quantiy of each kind of sock and then click the checkout button'
  end

  def quantity(zebra, lion, elephant, giraffe)
	 element = @driver.find_element(id: 'line_item_quantity_zebra').send_keys zebra
	 element = @driver.find_element(id: 'line_item_quantity_lion').send_keys lion
	 element = @driver.find_element(id: 'line_item_quantity_elephant').send_keys elephant
	 element = @driver.find_element(id: 'line_item_quantity_giraffe').send_keys giraffe
  end

end