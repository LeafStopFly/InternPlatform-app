# Intern Platform App
Web application for Internship system that allows people to share their experience in internships or interviews.

Please also note the Web API that it uses: https://github.com/LeafStopFly/InternPlatform-api

## Install

Install this application by cloning the *relevant branch* and use bundler to install specified gems from `Gemfile.lock`:

```shell
bundle install
```

## Test

This web app does not contain any tests yet :(

## Execute

Launch the application using:

```shell
rake run:dev
```

The application expects the API application to also be running (see `config/app.yml` for specifying its URL)