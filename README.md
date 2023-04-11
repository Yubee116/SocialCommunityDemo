# Overview
A lightweight community platform POC that allows users to register/sign up, create and join Groups, make posts within Groups, comment and reply to comments on posts in Groups to which they belong and lots more. 

**Used Technologies:** <br>
Rails 7, TailwindCSS, Hotwire: Turbo & Stimulus, ViewComponent, FontAwesome, Postgres, Heroku

View live app at https://secret-meadow-13172.herokuapp.com 
<br>

Follow the instructions below to setup and run in your local environment:

# Running the app locally
1. Clone this repository and change directory
```
$ git clone https://github.com/Yubee116/SocialCommunityDemo.git
$ cd SocialCommunityDemo 
```  

2. Run `bundle install`

3. Prepare the database: create, migrate and seed
```
$ rails db:create
$ rails db:migrate
$ rails db:seed
```

4. Start the sever by running the command `bin/dev`

5. Open `http://localhost:3000` in your browser
