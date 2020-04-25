#!/bin/bash

# Exit immeditely once script is finished
set -e

# Export action inputs as environment variables
export DATABASE_URL=$1
export DATABASE_PASSWORD=$2

# Install bundler
gem install bundler

# Exec main process
ruby /action/rails-minitest-action/main.rb

# Exit with status code from above
echo $?