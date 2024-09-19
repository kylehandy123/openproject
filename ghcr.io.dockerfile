FROM ruby:3.0

RUN apt-get update && apt-get install -y \
    build-essential \
    nodejs \
    postgresql-client \
    imagemagick \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone the forked repository
RUN git clone https://github.com/kylehandy123/openproject.git .

# Install gems
RUN bundle install

# Precompile assets
RUN SECRET_KEY_BASE=dummy RAILS_ENV=production bundle exec rake assets:precompile

EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]