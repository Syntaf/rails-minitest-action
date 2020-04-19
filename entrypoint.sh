#!/bin/bash

set -e

gem install bundler

# Exec main process
ruby /action/rails-minitest-action/main.rb