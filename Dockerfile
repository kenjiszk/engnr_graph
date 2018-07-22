FROM ruby:2.5.1-alpine

RUN apk upgrade --no-cache && \
    apk add --update --no-cache \
      tzdata \
      build-base \
      curl-dev \
      linux-headers \
      libxml2-dev \
      libxslt-dev \
      ruby-dev \
      yaml-dev \
      zlib-dev \
      mariadb-dev && \
    gem install bundler
COPY Gemfile* /app/
WORKDIR /app
RUN bundle install
