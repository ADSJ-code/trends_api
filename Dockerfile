FROM ruby:3.3.3 AS builder

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs default-libmysqlclient-dev

WORKDIR /rails

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN bundle exec rails assets:precompile

FROM ruby:3.3.3-slim

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
    libpq-dev \
    nodejs \
    default-libmysqlclient-dev \
    netcat-openbsd \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /rails

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

COPY --from=builder /rails/public/assets /rails/public/assets

COPY . .

ENTRYPOINT ["/rails/docker-entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]