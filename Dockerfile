FROM ruby:3.3.3-alpine AS builder

RUN apk update && apk upgrade && \
    apk add --no-cache build-base postgresql-dev nodejs yarn less imagemagick tzdata

WORKDIR /rails

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

RUN bundle exec rails assets:precompile

FROM ruby:3.3.3-alpine

RUN apk update && \
    apk add --no-cache libpq nodejs yarn less imagemagick netcat-openbsd \
    && rm -rf /var/cache/apk/*

WORKDIR /rails

COPY --from=builder /usr/local/bundle/ /usr/local/bundle/

COPY --from=builder /rails/public/assets /rails/public/assets

COPY . .

ENTRYPOINT ["/rails/docker-entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]