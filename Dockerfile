FROM ruby:2.5.1

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update \
    && apt-get install -y --no-install-recommends \
        nodejs postgresql-client yarn \
    && rm -rf /var/lib/apt/lists/*

# Copy application files and install the bundle
WORKDIR /app
COPY Gemfile* ./
RUN bundle install
COPY . .

# Run asset pipeline.
RUN bundle exec rake assets:precompile

EXPOSE 8080
CMD ["bundle", "exec", "rackup", "--port=8080", "--env=production"]
