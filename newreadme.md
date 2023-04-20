This is a article-blog application developed in Ruby on Rails with ruby version of 2.6.6

System Dependencies

1. RVM
2. Ruby 2.6.6
3. Rails ~> 5.2.0
4. PostgreSQL
5. Graphviz
6. Bundler

Installation Instructions

1. Install homebrew package
   $ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
2. Add Homebrew path
   $ export PATH="/opt/homebrew/bin:$PATH" >> ~/.zshrc
3. Install GnuPG with Homebrew
   $ brew install gnupg gnupg2
4. Install RVM(Ruby Version Manager)
   RVM required GPG Key to be installed
   To install GPG Key
   $ gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
5. Install Rvm with default Ruby & Rails
   $ \curl -sSL https://get.rvm.io | bash -s stable --rails
6. To install project version ruby & rails using rvm navigate to project directory on terminal & run
   $ rvm install $(cat .ruby-version) && rvm $(cat .ruby-version) do rvm gemset create $(cat .ruby-gemset) && rvm gemset use $(cat .ruby-gemset) && bundle install --jobs=$(nproc)
   It will now install required ruby & rails version
7. Install bundler with
   $ gem install bundler
8. Install Graphviz
   $ brew install graphviz
9. Install postgre sql with
   $ brew install postgresql@14
10. Install gems using bundler
    $ bundle install
11. Migrate database
    $ rails db:migrate
12. Seed Database
    $ rails db:seed
13. Start rails server
    $ rails server

For deployment in heroku

1. Install Heroku CLI using
   $ brew tap heroku/brew && brew install heroku
2. Login to heroku using command
   $ heroku login
3. As out app uses ruby 2.6.6 we need to use heroku-18 stack to create app using heroku-18
   $ heroku create --stack heroku-18
4. To change the stack use
   $ heroku stack:set heroku-18
5. Initialize git repository
   $ git init
6. Add all files to git
   $ git add .
7. Commit changes
   $ git commit -m "my application"
8. Push to created repository
   $ git push heroku main
9. To open app in url run
   $ heroku open
10. Migrate database
    $ heroku run rails db:migrate
11. Seed database
    $ heroku run rails db:seed

Now your app is all ready!
you can find demo app in
[Demo Link](https://aqueous-thicket-34312.herokuapp.com/users/sign_in?fbclid=IwAR3Ol8GOewmJ2UmX-pA_-vgujpAcybxLt1hHPVVAMQCDvvNLf5X3DNhslOM)
email: linwood.olson@example.com
password: test1234
