web: bundle exec rails server -p $PORT
worker:  rerun -d app/charts --pattern **/*.{rb} bundle exec rake jobs:work
clock: bundle exec clockwork lib/clock.rb