FROM ruby:2.5.1

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        nodejs postgresql-client \
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
