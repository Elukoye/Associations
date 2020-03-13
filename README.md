

# The Odin Project: [Private Events](https://www.theodinproject.com/courses/ruby-on-rails/lessons/associations)

## Live version of project :  [Private Events](https://warm-sea-24354.herokuapp.com/)


## Description:

* NOTE: This is in NO WAY a comprehensive walkthrough of the steps I used in the build, its just a rough set of notes for myself on the latest Odin Project app, Private Events. I've missed loads of bits out, most of it is html stuff, the main flow at the start is all in the correct order following the steps on the site so you could follow along, but at points things wouldn't work so you would need to dig into the code to find the missing things from these notes. Apart from that, it all works.

* Our Objective:

    We have to build a site similar to an [Eventbrite](https://www.eventbrite.com/) which allows users to create events and then manage user signups. I must be honest, I decided to cheat a little with this project and completely miss out the first part which was to setup the sign-in mechanism. I started with a copy and paste from our build of the rails tutorial up-to chapter 10. The reason I did this was I wanted to create a proper full featured application that I could use in production, so i wanted to save some time.

### Features:

* A user can register for an account
* A user can login 
* A user can change their account details
* A user can create events
* A user can attend events
* And a user can logout

* Bootstrap source in vendor/assets
* Font awesome CSS source
* Google Analytics Integration

![](https://github.com/Anna-Myzukina/associations/blob/master/app/assets/images/short%20commands.png)

### Box 7.1.RRT: Rails environments
*Rails comes equipped with three environments: test, development, and production. The default environment for the Rails console is development:

      $ rails console
      Loading development environment
      >> Rails.env
      => "development"
      >> Rails.env.development?
      => true
      >> Rails.env.test?
      => false
  
*As you can see, Rails provides a Rails object with an env attribute and associated environment boolean methods, so that, for example, Rails.env.test? returns true in a test environment and false otherwise.

If you ever need to run a console in a different environment (to debug a test, for example), you can pass the environment as a parameter to the console script:

      $ rails console test
      Loading test environment
      >> Rails.env
      => "test"
      >> Rails.env.test?
      => true
  
As with the console, development is the default environment for the Rails server, but you can also run it in a different environment:

    $ rails server --environment production
  
If you view your app running in production, it won’t work without a production database, which we can create by running rails db:migrate in production:

    $ rails db:migrate RAILS_ENV=production
  
(I find it confusing that the idiomatic commands to run the console, server, and migrate commands in non-default environments use different syntax, which is why I bothered showing all three. It’s worth noting, though, that preceding any of them with RAILS_ENV=<env> will also work, as in RAILS_ENV=production rails server).

By the way, if you have deployed your sample app to Heroku, you can see its environment using heroku run rails console:

      $ heroku run rails console
      >> Rails.env
      => "production"
      >> Rails.env.production?
      => true
  
Naturally, since Heroku is a platform for production sites, it runs each application in a production environment.

- [x] We can see the result of all this work by signing up the first user for the sample app. 
Even though previous submissions didn’t work properly (as shown in Figure 7.20), 
the user.save line in the Users controller still works, so users might still have been created. 
To clear them out, we’ll reset the database as follows: * This command sometimes useful ufter create signup form to reset database:

     rails db:migrate:reset

### Let's start build app:

1. create app

         rails _5.1.6_ new associations

2. change gemfile

            source 'https://rubygems.org'

            gem 'rails',        '5.1.6'
            gem 'bootstrap-sass', '3.3.7'
            gem 'bcrypt',         '3.1.12'
            gem 'rails-controller-testing'
            gem 'bootsnap'
            gem 'faker',          '1.7.3'
            gem 'will_paginate', '3.1.6'
            gem 'bootstrap-will_paginate', '1.0.0' 
            gem 'puma',         '3.9.1'
            gem 'sass-rails',   '5.0.6'
            gem 'uglifier',     '3.2.0'
            gem 'coffee-rails', '4.2.2'
            gem 'jquery-rails', '4.3.1'
            gem 'turbolinks',   '5.0.1'
            gem 'jbuilder',     '2.7.0'

            group :development, :test do
            gem "rspec-rails"
            gem 'capybara'
            gem 'selenium-webdriver'
            gem 'webdrivers'
            gem 'database_cleaner'
            gem 'sqlite3', '1.3.13'
            gem 'byebug',  '9.0.6', platform: :mri
            end


            group :development do
            gem 'web-console',           '3.5.1'
            gem 'listen',                '3.1.5'
            gem 'spring',                '2.0.2'
            gem 'spring-watcher-listen', '2.0.1'
            end

            group :production do
            gem 'pg', '0.20.0'
            end

            # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
            gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

        
        

After run next commands:

             bundle install
             
             
             bundle update

Run server to check if app works

    rails server

In browser type localhost:3000 to see that your app working

You can add next to see that your app working

![](https://github.com/Anna-Myzukina/associations/blob/master/app/assets/images/1.png)

![]()

## Create Static Page

* next command should generate two pages -home- and -about-
* now automatically generates home.html.erb and about.html.erb,here appare default content in this files to see what we
have you can visit localhost:3000/static_pages/home or localhost:3000/static_pages/about

        rails generate controller StaticPages home about
   
* This can be undone using

        rails destroy  controller StaticPages home about
        

        
## Next step we start generate Model-View-Controller (MVC):
![](https://github.com/Anna-Myzukina/asoosciation/blob/master/app/assets/images/MVC.png)

# User

#### Step 1 Build and migrate User model

        rails generate controller Users new
        
        rails generate model User name:string email:string

        rails db:migrate
        
 * This can be undone using

        rails destroy model User
        
        
        
#### Step 2 User validations from chapter 6 RRT [User validations](https://www.learnenough.com/ruby-on-rails-4th-edition-tutorial/modeling_users#sec-user_validations)

app/models/user.rb


        class User < ApplicationRecord
          validates :name,  presence: true, length: { maximum: 50 }
          VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
          validates :email, presence: true, length: { maximum: 255 },
                            format: { with: VALID_EMAIL_REGEX },
                            uniqueness: true
        end


* Here the regex VALID_EMAIL_REGEX is a constant, indicated in Ruby by a name starting with a capital letter.
* To enforce uniqueness of email addresses (so that we can use them as usernames), we’ll be using the :uniqueness option to the validates method

The email index represents an update to our data modeling requirements, which (as discussed in Section 6.1.1) is handled in Rails using migrations. We saw in Section 6.1.1 that generating the User model automatically created a new migration (Listing 6.2); in the present case, we are adding structure to an existing model, so we need to create a migration directly using the migration generator:

     rails generate migration add_index_to_users_email
     
* Add next code to file which was generated by previous command db/migrate/[timestamp]_add_index_to_users_email.rb
     
     
        class AddIndexToUsersEmail < ActiveRecord::Migration[5.0]
          def change
            add_index :users, :email, unique: true
          end
        end
        
        
* This uses a Rails method called add_index to add an index on the email column of the users table. The index by itself doesn’t enforce uniqueness, but the option unique: true does.

The final step is to migrate the database:

     rails db:migrate
     
#### Next we should follow RRT chapter [6.3 Adding a secure password](https://www.learnenough.com/ruby-on-rails-4th-edition-tutorial/modeling_users#sec-user_validations)
Run this:

        rails generate migration add_password_digest_to_users password_digest:string
        
Add here db/migrate/[timestamp]_add_password_digest_to_users.rb this:


        class AddPasswordDigestToUsers < ActiveRecord::Migration[5.0]
          def change
            add_column :users, :password_digest, :string
          end
        end
        
 After run:
 
        rails db:migrate
        
        
* To make the password digest, has_secure_password uses a state-of-the-art hash function called bcrypt. 
By hashing the password with bcrypt, we ensure that an attacker won’t be able to log in to the site even 
if they manage to obtain a copy of the database. To use bcrypt in the sample application, 
we need to add the bcrypt gem to our Gemfile (Listing 6.36).20

Listing 6.36: Adding bcrypt to the Gemfile.

source 'https://rubygems.org'

        gem 'rails',          '5.1.6'
        gem 'bcrypt',         '3.1.12'

Then run bundle install as usual:

        bundle install        


After change your file user.rb, you can find it app/models/user.rb


        class User < ApplicationRecord
          before_save { self.email = email.downcase }
          validates :name, presence: true, length: { maximum: 50 }
          VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
          validates :email, presence: true, length: { maximum: 255 },
                            format: { with: VALID_EMAIL_REGEX },
                            uniqueness: { case_sensitive: false }
          has_secure_password
          validates :password, presence: true, length: { minimum: 6 }
        end

#### Step 3 signup chapter 7 in RRT

Use this part from RRT [Sign up](https://www.learnenough.com/ruby-on-rails-4th-edition-tutorial/sign_up)

Add next code here controllers/users_controller.rb

        def show
            @user = User.find(params[:id])
          end

          def new
            @user = User.new
          end

          def create
            @user = User.new(user_params)
            if @user.save
              log_in @user
              flash[:success] = "Welcome to the Sample App!"
              redirect_to @user
            else
              render 'new'
            end
          end

          private

            def user_params
              params.require(:user).permit(:name, :email)
            end

### [Sessions controller](https://www.learnenough.com/ruby-on-rails-4th-edition-tutorial/basic_login#sec-sessions_and_failed_login)

    rails generate controller Sessions new

Add code to sessions controller 

        class SessionsController < ApplicationController
          def new
          end

          def create
            user = User.find_by(email: params[:session][:email].downcase)
            if user && user.authenticate(params[:session][:password])
              log_in user
              redirect_to user
            else
              flash[:danger] = 'Invalid email/password combination' # Not quite right!
              render 'new'
            end
          end

          def destroy
            log_out
            redirect_to root_url
          end
        end

app/views/users/show.html.erb

        <% provide(:title, @user.name) %>
        <div class="row">
          <aside class="col-md-4">
            <section class="user_info">
              <h1>

                <%= @user.name %>
              </h1>
            </section>
          </aside>
        </div>
 

Add cod to create form to file new.html.erb in app/views/users/new.html.erb

      <% provide(:title, 'Sign up') %>
        <h1>Sign up</h1>

        <div class="row">
          <div class="col-md-6 col-md-offset-3">
            <%= form_for(@user, url: signup_path) do |f| %>
            <%= render 'shared/error_messages' %>

              <%= f.label :name %>
               <%= f.text_field :name, class: 'form-control' %>

              <%= f.label :email %>
              <%= f.email_field :email, class: 'form-control' %>

              <%= f.label :password %>
               <%= f.password_field :password, class: 'form-control' %>

              <%= f.label :password_confirmation, "Confirmation" %>
              <%= f.password_field :password_confirmation, class: 'form-control' %>

              <%= f.submit "Create my account", class: "btn btn-primary" %>
            <% end %>
          </div>
        </div>
        
Now you can run server: rails s
In browser open your form http://localhost:3000/signup



Last step Signup error messages
As a final step in handling failed user creation, we’ll add helpful error messages to 
indicate the problems that prevented successful signup

- [ ] To create folder run next command

        mkdir app/views/shared
        
- [ ] To create file run command 

        touch app/views/shared/_error_messages.html.erb

Add next code to _error_messages.html.erb

        <% if @user.errors.any? %>
          <div id="error_explanation">
            <div class="alert alert-danger">
              The form contains <%= pluralize(@user.errors.count, "error") %>.
            </div>
            <ul>
            <% @user.errors.full_messages.each do |msg| %>
              <li><%= msg %></li>
            <% end %>
            </ul>
          </div>
        <% end %>

- [ ] Add style to custom.scss

        #error_explanation {
          color: red;
          ul {
            color: red;
            margin: 0 0 30px 0;
          }
        }

        .field_with_errors {
          @extend .has-error;
          .form-control {
            color: $state-danger-text;
          }
        }

#### Add structure and styles

- [ ] Combine Bootstrap with some custom CSS rules to start adding some style to the sample application. It’s worth noting that using Bootstrap automatically makes our application’s design responsive, ensuring that it looks sensible across a wide range of devices.

- [ ] Let's create structure:

1. Add this code to application.html.erb 

        <!DOCTYPE html>
        <html>
          <head>
            <title>Associations</title>
            <%= csrf_meta_tags %>

            <%= stylesheet_link_tag    'application', media: 'all', 'data-turbolinks-track': 'reload' %>
            <%= javascript_include_tag 'application', 'data-turbolinks-track': 'reload' %>
          </head>

          <body>
            <%= render 'layouts/header' %>
            <div class="container">
              <% flash.each do |message_type, message| %>
                <div class="alert alert-<%= message_type %>"><%= message %></div>
              <% end %>
              <%= yield %>
              <%= render 'layouts/footer' %>
              <%= debug(params) if Rails.env.development? %>
            </div>
        </html>
        
We add to footer <%= debug(params) if Rails.env.development? %> to Debug and Rails environments. 
After don't forgot delete it.

The profiles in this section will be the first truly dynamic pages in our application.
Although the view will exist as a single page of code, each profile will be customized
using information retrieved from the application’s database. 
As preparation for adding dynamic pages to our sample application, now is a 
good time to add some debug information to our site layout (Listing 7.1). 
This displays some useful information about each page using the built-in debug
method and params variable (which we’ll learn more about in Section 7.1.2).

Listing 7.1: Adding some debug information to the site layout.
app/views/layouts/application.html.erb

        <!DOCTYPE html>
        <html>
          .
          .
          .
          <body>
            <%= render 'layouts/header' %>
            <div class="container">
              <%= yield %>
              <%= render 'layouts/footer' %>
              <%= debug(params) if Rails.env.development? %>
            </div>
          </body>
        </html>
          
2. This to _header.html.erb you can find it here app/views/layouts/_header.html.erb

        <header class="navbar navbar-fixed-top navbar-expand-lg navbar-inverse">
                  <div class="container">

                    <%= link_to "Event App", root_path, id: "logo"  %>
                    <nav class="navbar">

                      <ul class="nav navbar-nav navbar-right d-flex">
                            <form class="form-inline my-2 my-lg-0">
                      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                    </form>

                            <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          Dropdown
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                          <a class="dropdown-item" href="#">Owerview</a>
                                    <div class="dropdown-divider"></div>
                          <a class="dropdown-item" href="#">Pricing</a>
                          <div class="dropdown-divider"></div>
                          <a class="dropdown-item" href="#">Blog</a>
                                    <div class="dropdown-divider"></div>
                          <a class="dropdown-item" href="#">Resources</a>
                        </div>
                      </li>

                    <li><a href="/static_pages/about">About</a></li>
                    <li><a href="/static_pages/home">Home</a></li>

                        <% if !logged_in? %>
                            <li><%= link_to "Sign Up", signup_path, class: "nav-link" %></li>
                      <li><%= link_to "Log In", login_path, class: "nav-link" %></li>
                        <% else %>


                            <li><%= link_to "Log Out", logout_path, method: :delete, class: "nav-link" %></li>
                        <% end %>
                   </ul>
                    </nav>
                  </div>
                </header>
                
3. This to _footer.html.erb you can fin it app/views/layouts/_footer.html.erb  

        <footer class="navbar fixed-bottom navbar-light col-md-12">
            <ul class="nav">
                <li class="nav-item">
                    <%= link_to "Home", root_path, class: "nav-link" %>
                </li>
            </ul>
        </footer>
        
        
4. This to about.html.erb

        <% provide(:title, 'Contact') %>
        <h1>About</h1>
        <p>
          We have to build a site similar to a Eventbrite which allows users to create events and then manage 
          user signups. I must be honest, I decided to cheat a little with this project and completely miss
          out the first part which was to setup the sign-in mechanism. I started with a copy and paste from 
          our build of the rails tutorial up-to chapter 10. The reason I did this was I wanted to create a 
          proper full featured application that I could use in production, so i wanted to save some time.
          </a>
        </p>
        
        
5. Something add to home.html.erb

        <h1>Events</h1>

                
1. Our first step is to add Bootstrap, which in Rails applications can be accomplished with the bootstrap-sass gem

Add the bootstrap-sass gem to the Gemfile.


        gem 'rails',          '5.1.6'
        gem 'bootstrap-sass', '3.3.7'
        
After run commands
        
        bundle install
        bundle update
        
2. Add file custom.css using next command

        touch app/assets/stylesheets/custom.scss

3 . After add next code to custom.scc, you can find this file in your project here: app/assets/stylesheets/custom.scss

        @import "bootstrap-sprockets";
        @import "bootstrap";
        
4. Next add this styles, we use it later

            /* universal */

            body {
              padding-top: 60px;
            }

            section {
              overflow: auto;
            }

            textarea {
              resize: vertical;
            }

            .center {
              text-align: center;
            }

            .center h1 {
              margin-bottom: 10px;
            }
            
And this for typography

            /* typography */

            h1, h2, h3, h4, h5, h6 {
              line-height: 1;
            }

            h1 {
              font-size: 3em;
              letter-spacing: -2px;
              margin-bottom: 30px;
              text-align: center;
            }

            h2 {
              font-size: 1.2em;
              letter-spacing: -1px;
              margin-bottom: 30px;
              text-align: center;
              font-weight: normal;
              color: #777;
            }

            p {
              font-size: 1.1em;
              line-height: 1.7em;
            }
            
Some styles for header

        /* header */

        #logo {
          float: left;
          margin-right: 10px;
          font-size: 1.7em;
          color: #fff;
          text-transform: uppercase;
          letter-spacing: -1px;
          padding-top: 9px;
          font-weight: bold;
        }

        #logo:hover {
          color: #fff;
          text-decoration: none;
        }
        
        

Something for form

            /* forms */

            input, textarea, select, .uneditable-input {
              border: 1px solid #bbb;
              width: 100%;
              margin-bottom: 15px;
              @include box_sizing;
            }
            .form-inline .form-control {
              margin-top: 14px;
            }
            .d-flex{
              display: flex;
            }

            input {
              height: auto !important;
            }

            /* dropdown menu*/

            .dropdown-item{
              display: block;
                width: 100%;
                padding: .25rem 1.5rem;
                clear: both;
                font-weight: 400;
                color: #212529;
                text-align: inherit;
                white-space: nowrap;
                background-color: transparent;
                border: 0;
            }
            .dropdown-item:hover{
              background: rgba(209, 207, 207, 0.726);
            }
            .dropdown-divider{
              height: 0;
              overflow: hidden;
              border-top: 1px solid #e9ecef;
            }

A little code for footer

            /* footer */

            footer {
              margin-top: 45px;
              padding-top: 5px;
              border-top: 1px solid #eaeaea;
              color: #777;
            }

            footer a {
              color: #555;
            }

            footer a:hover {
              color: #222;
            }

            footer small {
              float: left;
            }

            footer ul {
              float: right;
              list-style: none;
            }

            footer ul li {
              float: left;
              margin-left: 15px;
            }
            
Last this two lines add to file application.js you can find it here: app/assets/javascripts/application.js   
  
    //= require jquery
    //= require bootstrap

### Step 4 Log in/ Log out chapter 8 RRT
Now that new users can sign up for our site (Chapter 7), it’s time to give them the ability to log in and log out.

Use thp part from RRT [Log in](https://www.learnenough.com/ruby-on-rails-4th-edition-tutorial/basic_login)

#### Step 1 Sessions controller

        rails generate controller Sessions new


Make changes in rotes.rb file you can find it here config/routes.rb

        Rails.application.routes.draw do

          root 'static_pages#home'

          get 'static_pages/home'
          get 'static_pages/about'

          get  '/signup',  to: 'users#new'
          post '/signup',  to: 'users#create'

          get    '/login',   to: 'sessions#new'
          post   '/login',   to: 'sessions#create'
          delete '/logout',  to: 'sessions#destroy'

          get 'sessions/new'

          get 'users/new'


          resources :users
        end
        
        
  Since we’ve now added several custom named routes, it’s useful to look at the complete list of
  the routes for our application, which we can generate using 
  Run in terminal next:
  
        rails routes
        
  After run this command you can see      
        
        
 ![]()    
        
        
 Let's add form for login      
        
      <% provide(:title, "Log in") %>
        <h1>Log in</h1>

        <div class="row">
          <div class="col-md-6 col-md-offset-3">
            <%= form_for(:session, url: login_path) do |f| %>

              <%= f.label :email %>
              <%= f.email_field :email, class: 'form-control' %>

              <%= f.submit "Log in", class: "btn btn-primary" %>
            <% end %>

            <p>New user? <%= link_to "Sign up now!", signup_path %></p>
          </div>
        </div>
        

2. This to _header.html.erb you can find it here app/views/layouts/_header.html.erb

        <header class="navbar navbar-fixed-top navbar-expand-lg navbar-inverse">
                  <div class="container">

                    <%= link_to "Event App", root_path, id: "logo"  %>
                    <nav class="navbar">

                      <ul class="nav navbar-nav navbar-right d-flex">
                            <form class="form-inline my-2 my-lg-0">
                      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
                      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                    </form>

                            <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                          Dropdown
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                          <a class="dropdown-item" href="#">Owerview</a>
                                    <div class="dropdown-divider"></div>
                          <a class="dropdown-item" href="#">Pricing</a>
                          <div class="dropdown-divider"></div>
                          <a class="dropdown-item" href="#">Blog</a>
                                    <div class="dropdown-divider"></div>
                          <a class="dropdown-item" href="#">Resources</a>
                        </div>
                      </li>

                    <li><a href="/static_pages/about">About</a></li>
                    <li><a href="/static_pages/home">Home</a></li>

                        <% if !logged_in? %>
                            <li><%= link_to "Sign Up", signup_path, class: "nav-link" %></li>
                      <li><%= link_to "Log In", login_path, class: "nav-link" %></li>
                        <% else %>


                            <li><%= link_to "Log Out", logout_path, method: :delete, class: "nav-link" %></li>
                        <% end %>
                   </ul>
                    </nav>
                  </div>
                </header>



# Event

1.

        rails generate model Event content:text user:references
        
        
2. Listing 13.3: The Micropost migration with added index.
db/migrate/[timestamp]_create_events.rb


    class CreateEvents < ActiveRecord::Migration[5.0]
      def change
        create_table :events do |t|
          t.text :content
          t.references :user, foreign_key: true

          t.timestamps
        end
        add_index :events, [:user_id, :created_at]
      end
    end

3. 

            rails db:migrate

4. Events validations

Listing 13.5: A validation for the events’s user_id. green
app/models/event.rb

    class Event < ActiveRecord::Base
      belongs_to :user
      validates :user_id, presence: true
    end


5. User/Events associations

Listing 13.11: A user has_many events. green
app/models/user.rb

    class User < ApplicationRecord
      has_many :eveents
      .
      .
      .
    end

* Dependent: destroy

Apart from proper ordering, there is a second refinement we’d like to add to events. Recall from Section 10.4 that site administrators have the power to destroy users. It stands to reason that, if a user is destroyed, the user’s events should be destroyed as well.

We can arrange for this behavior by passing an option to the has_many association method, as shown in Listing 13.19.

Listing 13.19: Ensuring that a user’s events are destroyed along with the user.
app/models/user.rb

    class User < ApplicationRecord
      has_many :events, dependent: :destroy
      .
      .
      .
    end


* Showing events


      rails generate controller Microposts



# Build and migrate your Event model


    rails generate controller Event new
    
    rails generate model Event location:string date:date
    
    rails db:migrate

* If something wrong you can undo this command rails db:migrate with a single command, called db:rollback    

        rails db:rollback

     
## Step 2 Associations between the User and Event

Add the association between the event creator (a User) and the event. 
Call this user the "creator".

### In app\models\event.rb

    belongs_to :creator, :class_name => "User"

### In app\models\user.rb

    has_many :events, :foreign_key => :creator_id

### Add the foreign key to the Events model

    rails generate migration add_creator_to_events creator_id:integer

### Also add the index to the migration

Add to file db/migrate/[timestamp]_create_microposts.rb next code

    add_index :events, :creator_id

Then run in terminal

    bundle exec rake db:migrate

## Step 3 User's Show page to list all users events

      <% if @user.events.any? %>
        <h3>Submitted (<%= @user.events.count %>) events</h3>
        <ul class="media-list">
          <%= render @events %>
        </ul>
        <%= will_paginate @events %>
      <% else %>
        <h3>No Events Found</h3>
      <% end %>

### The above renders the event from app/views/events/_event.html.erb

    <li class="media">
      <div class="media-left">
        <a href="#"><%= gravatar_for user, size: 50 %></a>
      </div>
      <div class="media-body">
        <h4 class="media-heading">Media heading</h4>
      </div>
    </li>

## Step 4 Create the Events Controller and routes

  rails generate controller Events

Steps 5, 6, 7, and 8
For steps 5 to 8:

    rails generate migration add_desc_to_events description:text

    bundle exec rake db:migrate

Do all the normal CRUD actions and views.

    rails generate migration add_title_to_events title:string

    bundle exec rake db:migrate

## Attendance :

## Step 1

### In app\models\user.rb

    has_many :attended_events,  :through => :event_attendees
    has_many :event_attendees,  :foreign_key => :attendee_id

### In app\models\event.rb

    has_many :attendees, 		:through => :event_attendees
    has_many :event_attendees,  :foreign_key => :attended_event_id

## Step 2

    rails generate model EventAttendee attendee_id:integer attended_event_id:integer
    rails generate controller EventAttendees
    bundle exec rake db:migrate

### In app\models\event_attendee.rb

    belongs_to :attendee, 		:class_name => "User"
    belongs_to :attended_event, :class_name => "Event"

    validates :attendee_id, 		presence: true
    validates :attended_event_id, 	presence: true

## Step 3 The event's show page to display a list of attendees

    <% if @event.attendees.any? %>
        <% @event.attendees.each do |attendee| %>
            <span class="attendee">
                <%= attendee.username %>
            </span> <br/>
        <% end %>
    <% else %>
        No attendees
    <% end %><br/>

## Step 4 The user's show page to display a list of events he is attending

    <% if @user.attended_events.any? %>
      <h2>Upcoming Events</h2> 
      <ul class="media-list">
        <%= render @upcoming_events %>
      </ul>
    <% else %>
      <h2>No Upcoming Events</h2>
    <% end %>

### In app\controllers\users_controller.rb

    @upcoming_events = @user.upcoming_events

## Step 5 On the user's show page show the past events

    <% if @events.past.any? %>
      <ul class="media-list">
        <%= render @events.past %>
      </ul>
    <% end %>

#### In app\models\user.rb

### Methods used in the user model

    def upcoming_events
      self.attended_events.upcoming
    end

    def previous_events
      self.attended_events.past
    end	

## Step 6 app\views\events\index.html.erb

      <h2>Upcoming Events</h2>
      <% if @events.upcoming.any? %>
        <ul class="media-list">
          <%= render @events.upcoming %>
        </ul>
        <%= will_paginate @events.upcoming %>
      <% else %>
        <h3>Events (0)</h3>
        <%= link_to new_event_path, class: 'btn btn-success' do %>
          Add Event <i class="fa fa-plus-circle"></i>
        <% end %>
      <% end %>

    <h2>Past Events</h2>
    <% if @events.past.any? %>
      <ul class="media-list">
        <%= render @events.past %>
      </ul>
      <%= will_paginate @events.past %>
    <% end %>

## Step 7 Simple Scopes in app\models\event.rb

    scope :upcoming, -> { where("Date >= ?", Date.today).order('Date ASC') }
    scope :past, 	 -> { where("Date <  ?", Date.today).order('Date DESC') }

## Step 8 Navigation

    Bootstrap nav used

## Step 9 Extra Credit

### In app\models\user.rb

    def attending?(event)
      event.attendees.include?(self)
    end

    def attend!(event)
      self.event_attendees.create!(attended_event_id: event.id)
    end

    def cancel!(event)
      self.event_attendees.find_by(attended_event_id: event.id).destroy
    end

### In app\views\events\show.html.erb

    <%= render 'attend_cancel' %>

### attend form in app\views\events

    <% if logged_in? && current_user.attending?(@event) %> 
      <%= render 'cancel' %>
    <% else %>
      <%= render 'attend' %>
    <% end %>

### cancel form in app\views\events

    <%= form_for(current_user.event_attendees.find_by(attended_event_id: @event.id),
      html: { method: :delete }) do |f| %>
      <%= f.submit "Cancel", class: "btn btn-sm btn-default" %>
    <% end %>

### attend form in app\views\events

    <% if logged_in? %>
      <%= form_for(current_user.event_attendees.build(attended_event_id: @event.id)) do |f| %>
      <%= f.hidden_field :attended_event_id %>
        <%= f.submit "Attend", class: "btn btn-sm btn-primary" %>
      <% end %>
    <% end %>

## Step 10

    git push

#### Testing in the console:
To run console use next command => rails c

### Users

    u = User.first (Grab the first user)
    u.events.count ( Return the number of events )
    u.events ( Grab that users events )

    u.attended_events (Grab all events that user is going to - USING the join )
    u.event_attendees ( Returns the event and user id's NOT using the join )

### Events

    e = Event.first (Grab the first event)
    e.attendees (Grab events attendees (returns user objects) - GOING THROUGH the join )
    e.event_attendees ( Returns the event and user id's NOT GOING through the join )
    e.attendees.find(2).username  (Return the username of the user going to that event) 
    e.creator ( The user object that created the event )
    e.creator.username ( Pull out the creator username from the user object )

    e = Event.last
    e.creator.username
    e.attendees.each { |a| puts a.username }

### Looking at the upcoming and past scopes

    e = Event.all (Grab all the events)
    e.upcoming ( list all upcoming events )
    e.past ( list all past events )
    
    
## Show your support

Give a ⭐️ if you like this project!

## 📝 License:

* See [LICENSE.md](https://github.com/Anna-Myzukina/MembersOnly/blob/master/LICENSE.md) for details.

## Authors:

👤 **Author1**
* [Anna Muzykina](https://github.com/Anna-Myzukina)

👤 **Author2**
* [Emogene Akwiri](https://github.com/Elukoye)
