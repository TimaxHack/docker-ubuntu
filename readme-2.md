## Установка докера

### Установка докера
```
sudo apt install -y git curl docker.io docker-compose
```
### Добавление группы докера
```
sudo groupadd docker
```
### Обозначить мод пользователя
```
sudo usermod -aG docker $(whoami)
```

## Устнановка nvm и node

### Установка nvm
```
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```
### Установка node
```
nvm install 18 && nvm use 18 && nvm alias default 18
```


## Установка docker-compose

### Загрузите текущую стабильную версию Docker Compose:
```
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
```

### Присвойте права на выполнение:
```
chmod +x /usr/local/bin/docker-compose
```

## Глобальные переменные хостов
```
export DEEPCASE_HOST="chatgpt.deep.foundation"
export DEEPLINKS_HOST="deeplinks.chatgpt.deep.foundation"
```

## Клонирование репы
```
git clone https://github.com/deep-foundation/dev
```


## Установка зависимостей
```
cd dev && npm ci
```

## Запуск configure-nginx.js
```
node configure-nginx.js --configurations "$DEEPCASE_HOST 3007" "$DEEPLINKS_HOST 3006" --certbot-email drakonard@gmail.com
```

## Удаление диплинкс и установка версии латескс
```
npm rm --unsafe-perm -g @deep-foundation/deeplinks
npm install --unsafe-perm -g @deep-foundation/deeplinks@latest
```

## Рандомные глобальные переменные
```
export HASURA_ADMIN_SECRET=$(node -e "console.log(require('crypto').randomBytes(24).toString('hex'));")
export POSTGRES_PASSWORD=$(node -e "console.log(require('crypto').randomBytes(24).toString('hex'));")
export MINIO_ACCESS_KEY=$(node -e "console.log(require('crypto').randomBytes(24).toString('hex'));")
export MINIO_SECRET_KEY=$(node -e "console.log(require('crypto').randomBytes(24).toString('hex'));")
```
## Глобальная переменна JWT_SECRET
```
JWT_SECRET=$(node -e "console.log(JSON.stringify({type: 'HS256', key: require('crypto').randomBytes(50).toString('base64')}));")
```

## Содержимое call-options.json
```
{
  "operation": "run",
  "envs": {
    "DEEPLINKS_PUBLIC_URL": "https://$DEEPLINKS_HOST",
    "NEXT_PUBLIC_DEEPLINKS_URL": "https://$DEEPLINKS_HOST",
    "NEXT_PUBLIC_GQL_PATH": "$DEEPLINKS_HOST/gql",
    "NEXT_PUBLIC_GQL_SSL": "1",
    "NEXT_PUBLIC_DEEPLINKS_SERVER": "https://$DEEPCASE_HOST",
    "NEXT_PUBLIC_ENGINES_ROUTE": "0",
    "NEXT_PUBLIC_DISABLE_CONNECTOR": "1",
    "JWT_SECRET": "$JWT_SECRET",
    "DEEPLINKS_HASURA_STORAGE_URL": "http://host.docker.internal:8000/",
    "HASURA_GRAPHQL_ADMIN_SECRET": "$HASURA_ADMIN_SECRET",
    "MIGRATIONS_HASURA_SECRET": "$HASURA_ADMIN_SECRET",
    "DEEPLINKS_HASURA_SECRET": "$HASURA_ADMIN_SECRET",
    "POSTGRES_PASSWORD": "$POSTGRES_PASSWORD",
    "HASURA_GRAPHQL_DATABASE_URL": "postgres://postgres:$POSTGRES_PASSWORD@postgres:5432/postgres",
    "POSTGRES_MIGRATIONS_SOURCE": "postgres://postgres:$POSTGRES_PASSWORD@host.docker.internal:5432/postgres?sslmode=disable",
    "RESTORE_VOLUME_FROM_SNAPSHOT": "0",
    "MANUAL_MIGRATIONS": "1",
    "MINIO_ROOT_USER": "$MINIO_ACCESS_KEY",
    "MINIO_ROOT_PASSWORD": "$MINIO_SECRET_KEY",
    "S3_ACCESS_KEY": "$MINIO_ACCESS_KEY",
    "S3_SECRET_KEY": "$MINIO_SECRET_KEY"
  }
}
```

## Глобальные переменные дэбага и удаление вызова опции
```
export DEEPLINKS_CALL_OPTIONS=$(cat call-options.json)
export DEBUG="deeplinks:engine:*,deeplinks:migrations:*"
```

## Запуск
```
deeplinks
```
