User.create!({:email => "calvin@simplero.com", :password => 'simplero', :password_confirmation => 'simplero'})
User.create!({:email => "owais@simplero.com", :password => 'simplero', :password_confirmation => 'simplero'})
8.times do |index|
    begin
        User.create!({:email => "user#{index}@example.com", :password => 'password', :password_confirmation => 'password'})
    rescue => ex
        puts ex
    end
end