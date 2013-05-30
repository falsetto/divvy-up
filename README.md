![Divvy Up](https://dl.dropboxusercontent.com/u/1238280/divvy-up/divvy-up-logo.png)

Solve the simple workflow of divvying up portions of your paychecks into various savings “buckets.”

# How to bootstrap development

## Export env vars for Twitter auth

```
$ export TWITTER_SECRET=...
$ export TWITTER_KEY=...
```

## Install dependencies

Note: `npm` comes with [Node.js](http://nodejs.org/)

`$ bundle install`
`$ npm install -g karma`

## Set up databases

```
$ bundle exec rake db:migrate
$ bundle exec rake db:test:prepare
```

## Start up dev server and test runners

`$ bundle exec foreman start`

Note: Rails test are not currently executed by Foreman as the exit code from the Rake task kills the entire Foreman process. Until I can figure out how to remedy this, you'll need to run Rails tests by hand:

`$ bundle exec rake test`
