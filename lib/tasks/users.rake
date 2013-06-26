require 'csv'

desc "send users email"
task :users_email => :environment do
	user = Spree::User.find(:all)
	user.each do |d|
		u.send_reset_password_instructions
	end
end

desc "Import users into database from csv file"
task :import => [:environment] do

  file = File.read("db/edd.csv")
  csv = CSV.parse(file, :headers => true)
  csv.each do |row|
    print " ! " + row[0] + " ! " + row[2] + " ! " + row[3] + " ! " + row[4] + " ! " + row[5] + " ! " + row[6] + "\n"
    Spree::User.create(:email => row[4] )
  end
end

# if the product row === this earl. create order for that user of the product they ordered.
# then call send_reset_password_instructions