FROM ruby:2.2.5
ENV LANG C.UTF-8
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev mysql-client
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

RUN curl -sL https://deb.nodesource.com/setup_7.x | bash - && \
apt-get install nodejs

RUN gem install bundler
RUN mkdir /floap
WORKDIR /floap
ADD Gemfile /floap/Gemfile
ADD Gemfile.lock /floap/Gemfile.lock
RUN bundle install --path vendor/bundle
ADD . /floap
