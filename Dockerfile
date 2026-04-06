FROM ruby:3.3-slim-bookworm

LABEL maintainer="your-email@example.com"
LABEL description="Docker container for Jekyll Chirpy theme development"

WORKDIR /app

ENV NODE_VERSION=20
ENV BUNDLE_PATH=/usr/local/bundle
ENV GEM_HOME=/usr/local/bundle
ENV PATH="${GEM_HOME}/bin:${PATH}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    curl \
    libffi-dev \
    libyaml-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash - \
    && apt-get install -y --no-install-recommends nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN npm install -g npm@latest

COPY Gemfile* ./
COPY package*.json ./

RUN gem install bundler
RUN bundle config set --local path 'vendor/bundle'
RUN bundle install

RUN npm install

EXPOSE 4000 35729

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload", "--incremental"]
