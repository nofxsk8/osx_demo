class Cart < ActiveRecord::Base
  has_many :line_items
  
  def total_price
    # convert to array so it doesn't try to do sum on database directly
    line_items.to_a.sum(&:full_price)
  end
  
  def skrill_url()
    values = {
      :pay_to_email => 'mb654@abv.bg',
      :currency => 'USD',
      :language => 'EN',
      :return_url => 'http://127.0.0.1:3000/products',
      :cancel_url => 'http://127.0.0.1:3000/carts',
      :amount => total_price
    }
    #line_items.each_with_index do |item, index|
    #  values.merge!({
    #    "amount_#{index+1}" => item.unit_price,
    #    "item_name_#{index+1}" => item.product.name,
    #    "item_number_#{index+1}" => item.id,
    #    "quantity_#{index+1}" => item.quantity
    #  })
    #end
    "https://www.moneybookers.com/app/payment.pl?" + values.to_query
  end
end
