Factory.define :user do | user | 
	user.name    					"Justin Vargas"
	user.password					"foobar"
	user.email						"jvargas@example2.com"
	user.password_confirmation	"foobar"
end

Factory.sequence :email do |n|
	"person-#{n}@example.com"
end	
	
