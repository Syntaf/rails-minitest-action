#!/bin/bash

set -e

export DATABASE_URL=$2
export DATABASE_PASSWORD=$3

gem install bundler

# Exec main process
ruby /action/rails-minitest-action/main.rb