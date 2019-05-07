FROM ruby:2.5.1

RUN apt-get update && apt-get install -y nodejs sqlite3 vim --no-install-recommends && rm -rf /var/lib/apt/lists/*

WORKDIR app

ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

COPY Gemfile .ruby-version ./

RUN gem update --system
RUN gem install bundler
RUN bundle install

COPY . ./
RUN bundle exec rake assets:precompile
RUN rails credentials:edit

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
