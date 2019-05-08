FROM ruby:2.5.1

# Install nodejs, yarn, and postgresql-client
RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs yarn postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Create app folder and make it working directory
WORKDIR /app

# Set RAILS env variables
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

# Copy Gemfile and Gemfile.lock files and bundle the project
COPY Gemfile Gemfile.lock ./
RUN bundle config --global frozen 1
RUN bundle install --without development test

# Copy application files
COPY . ./

# Compile assets
RUN bundle exec rake assets:precompile
