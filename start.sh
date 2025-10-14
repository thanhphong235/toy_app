#!/bin/bash

# 1. Migrate database
bundle exec rake db:migrate

# 2. Precompile assets (nếu chưa precompile)
bundle exec rake assets:precompile

# 3. Đặt PORT nếu chưa có
export PORT=${PORT:-3000}

# 4. Start Rails server
bundle exec rails server -b 0.0.0.0 -p $PORT
