# syntax = docker/dockerfile:1

# docker run -d -p 80:80 -p 443:443 --name my-app -e RAILS_MASTER_KEY=<value from config/master.key> my-app
# Definir a versão do Ruby igual à do ambiente de desenvolvimento
ARG RUBY_VERSION=3.3.1
FROM ruby:$RUBY_VERSION-slim

# Definir variáveis de ambiente para Rails
ENV RAILS_SERVE_STATIC_FILES=true

# Secret key base temporário apenas para compilação de assets
ENV SECRET_KEY_BASE=dummy-key-for-asset-precompilation-only

# Adicionar PATH do bundler explicitamente (opcional, já está configurado na imagem base)
ENV PATH="/usr/local/bundle/bin:${PATH}"

SHELL ["/bin/bash", "-c"]

# Instalar Node.js e npm junto com as outras dependências
RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    npm \
    libvips \
    bash \
    procps \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

# Criar usuário da aplicação
RUN adduser --disabled-password --gecos "" app

# Criar diretório da aplicação
WORKDIR /app

# Copiar Gemfile e instalar dependências
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs 4 --retry 3

RUN chown -R app:app /usr/local/bundle

# Copiar o código da aplicação
COPY --chown=app:app . .

# Instalar dependências do Node.js

# Copiar o arquivo credentials.yml.enc para o diretório de configuração
COPY config/credentials.yml.enc config/credentials.yml.enc

# Compilar assets
RUN bundle exec rake assets:precompile

# Configurar permissões
RUN chown -R app:app /app

# Mudar para o usuário da aplicação
USER app

# Expor a porta do Rails
EXPOSE 3000

# Comando para iniciar a aplicação
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000"]
