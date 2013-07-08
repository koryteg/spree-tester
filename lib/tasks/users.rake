require 'csv'

desc "send users email"
task :users_email => :environment do
	user = Spree::User.find(:all)
	user.each do |u|
		u.send_reset_password_instructions
	end
end

desc "importing products into database"
task :import_products => [:environment] do
  products = [
  {
    :name => "Earl Coal",
    :tax_category => clothing,
    :price => 300,
  },
  {
    :name => "Earl Snow",
    :tax_category => clothing,
    :price => 300,
  }
]
  products.each do |product_attrs|
    eur_price = product_attrs.delete(:eur_price)
    Spree::Config[:currency] = "USD"

    default_shipping_category = Spree::ShippingCategory.find_by_name!("Default Shipping")
    product = Spree::Product.create!(default_attrs.merge(product_attrs), :without_protection => true)
    Spree::Config[:currency] = "EUR"
    product.reload
    product.price = eur_price
    product.shipping_category = default_shipping_category
    product.save!
  end
end

desc "Import users into database from csv file"
task :import_users => [:environment] do

  file = File.read("db/edd.csv")
  csv = CSV.parse(file, :headers => true)
  csv.each do |row|
    print " ! " + row[0] + " ! " + row[2] + " ! " + row[3] + " ! " + row[4] + " ! " + row[5] + " ! " + row[6] + "\n"
    address = Spree::Address.create!({
      :firstname => row[2],
      :lastname => row[3],
      :address1 => row[5],
      :address2 => row[6],
      :city => row[7],
      :state => Spree::State.where(abbr: row[8]).first,
      :zipcode => row[9],
      :country => Spree::Country.where(iso: row[10]).first,
      :phone => "5555555555"
      }, :without_protection => true )
    user = Spree::User.create!({
      :email => row[4], 
      :password => "welcome", 
      :password_confirmation => "welcome", 
      :first_name => row[2],
      :last_name => row[3],
      :bill_address => address
      }, :without_protection => true )
  end
end

desc "import orders"
task :import_orders do
  orders = Spree::Order.create!({
    :number => "R123456789",
    :email => "spree@example.com",
    :item_total => 150.95,
    :adjustment_total => 150.95,
    :total => 301.90,
    :shipping_address => Spree::Address.first,
    :billing_address => Spree::Address.last
    }, :without_protection => true)
end
