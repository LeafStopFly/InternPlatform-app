![](https://img.shields.io/badge/Ruby-3.0.1-green)
# ISS Internship Platform App
Our purpose is to set up an experience sharing platform for ISS, so that the experience of internship or interview can be passed on to younger students.

Everyone can share their experience on the platform, including internship & interview experience sharing. They can choose whether to post anonymously and watch the experience sharing of previous ISS students.

Please also note the Web API that it uses: https://github.com/LeafStopFly/InternPlatform-api

## Install

Install this application by cloning the *relevant branch* and use bundler to install specified gems from `Gemfile.lock`:

```shell
bundle install
```

## Test

```shell
rake spec
```

## Execute

Launch the application using:

```shell
rake run:dev
```

The application expects the API application to also be running (see `config/app.yml` for specifying its URL)

## Website

Our website: https://intern-platform--app.herokuapp.com/

1. Can use your github account to login in, or register an account for ISS Internship platform and login in.

![image](https://github.com/LeafStopFly/InternPlatform-app/tree/master/pic/1.PNG)

2. Can see others internship or interview articles in sharing pages.

![image](https://github.com/LeafStopFly/InternPlatform-app/tree/master/pic/2.jpeg)

3. Can post internship or interview articles and choose to be anonymous or not.

![image](https://github.com/LeafStopFly/InternPlatform-app/tree/master/pic/3.jpeg)

4. After publishing the article, if the owner wants to modify it, can edit or delete it directly in mypost page.

![image](https://github.com/LeafStopFly/InternPlatform-app/tree/master/pic/4.jpeg)