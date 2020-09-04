# Welcome to Note Storage

This is a simple note storage application using Ruby on Rails. For demo of this application please follow this link [Note Storage Demo Application](https://note-storage.herokuapp.com).

## Application Description
- User can signup into this application by providing email, password and password confirmation.
- User can login into this application by providing email and password.
- User can create note by clicking *New Note* button.
- User can edit note by clicking *Edit* link of respective note.
- User can delete note by clicking *Delete* link of respective note.
- User can search note by using search form.
- User can logout from application by clicking *Log Out* link at the navbar.

## Technical Stack
- Ruby v2.6.6
- Rails v6.0.3
- postgres 1.2.3

## Development Setup

- Set up Ruby on Rails on linux based OS. For installation please follow this link [Ruby and Rails Installation Guide](https://gorails.com/setup/ubuntu/18.04). Here please use **RVM** for the development.
- Clone this repository into your system. [Clone GitHub Repository Guide](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository)
- Open terminal and go to the project path.
- It will create one gemset for this project. Please install bundler first. For the installation of bundler please run this bellow command.
  > gem install bundler
- Install all gem by following bellow command.
  > bundle install
- Start rails server with bellow command.
    > rails server
- Visit [http://localhost:3000](http://localhost:3000). You are on home page.

## Testing

Rspec is there for unit testing. After running test suite one test coverage will be generated inside the project folder. For this test coverage *SimpleCov* has been used.

![test coverage](https://github.com/sukanta-m/user-notes-api/blob/master/vendor/coverage.png?raw=true)