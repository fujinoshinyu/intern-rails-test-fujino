FROM ruby:2.7.4
RUN apt-get update -qq \
    && apt-get install -y nodejs postgresql-client npm \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && rm -rf /var/lib/apt/lists/* \
    && npm install --global yarn
RUN mkdir /myapp
WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN gem install --conservative bundler -v '~> 2.2.25'
RUN bundle install
COPY . /myapp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]