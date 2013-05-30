web_e2e: bundle exec rails s -p 3001 -e e2e_test
karma_e2e: sleep 5 && karma start --port 8080 karma-e2e.conf.js
karma_unit: karma start --port 8081
web_dev: bundle exec rails s
# TODO: Figure out how to prevent 'rake test' exit code from killing Foreman
# rake_test: bundle exec kicker -s -q -e 'bundle exec rake test' app test
