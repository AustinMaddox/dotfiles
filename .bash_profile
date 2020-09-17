PATH=$PATH:/usr/local/Cellar/php@7.1/7.1.22/bin/

# Misc
######
alias ab='docker run --rm --interactive --tty --network="local-network" --volume "$PWD":/docker-container-workdir --workdir /docker-container-workdir --user $(id -u):$(id -g) austinmaddox/docker-apache-ab:master'
alias cdd='cd ~/p/Klowd/'
alias consul='/etc/consul.d/consul agent -config-dir=/etc/consul.d/'
alias ea='vi ~/.bash_profile'
alias ll='ls -l -A -G -H'
alias myip='ifconfig | grep "inet " | grep -v "127.0.0.1"'
alias reloadshell='source ~/.bash_profile'
alias update-postman-on-linux='wget https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz && sudo tar -xzf postman.tar.gz -C /opt/ && rm -rf postman.tar.gz'
alias update-postman-on-mac='curl https://dl.pstmn.io/download/latest/osx -o postman.zip && unzip -o postman.zip && cp -rf Postman.app /Applications'
alias vim='vi'

watch() {
  while :; 
    do 
    clear
    echo "Watching $@"
    "$@"
    sleep 1
  done
}

# AWS
#####
alias aws='docker run --rm --interactive --tty --name="aws-cli-v2-container" --volume ~/.aws:/root/.aws --volume $(pwd):/aws amazon/aws-cli'
alias awsenv='aws ssm send-command --cli-input-json="file://aws-ssm-env-rico.json" --document-name="AWS-RunShellScript" --profile="rico" --region="us-west-2"'
alias ecr='aws ecr get-login --region="us-west-2" --no-include-email'
alias ssh_dev='ssh -i ~/.ssh/klowd-dev.pem -l ubuntu'
alias ssh_prod='ssh -i ~/.ssh/klowd-prod.pem -l ubuntu'

# Docker
########
alias dcb='docker-compose build'
alias dcd='docker-compose down; docker ps -a'
alias dcl='docker-compose logs'
alias dcp='docker container prune'
alias dcr='docker-compose run --rm --service-ports'
alias dcu='docker-compose up'
alias dcs='docker-compose stop'
alias dcuad='docker-compose up -d && fixFilesystemAlpineDrupal && docker ps -a'
alias dcudd='docker-compose up -d && fixFilesystemDebianDrupal && docker ps -a'
alias dcual='docker-compose up -d && fixFilesystemAlpineLaravel && docker ps -a'
alias dcudl='docker-compose up -d && fixFilesystemDebianLaravel && docker ps -a'
alias de='docker exec --interactive --tty'
alias di='docker images'
#alias diclean='docker images --filter dangling=true -q | xargs -n1 -r docker rmi'
alias diclean='docker rmi $(docker images -q -f dangling=true)'
alias dic='diclean'
alias dl='docker logs --details --follow --tail 10'
alias dm='screen ~/Library/Containers/com.docker.docker/Data/vms/0/tty'
alias dn='docker network'
alias dnls='docker network ls'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias dsp='docker system prune'
alias dv='docker volume'
alias dvls='docker volume ls'
alias dstop='docker stop $(docker ps -a -q) && dpsa'
alias teardown='dstop && exit'

# Drupal filesystem permissions.
################################
alias fixFilesystemAlpineDrupal='sudo sh -c "chown -R $(whoami):10000 $PWD && for d in ./sites/*/files; do find ${d} -type d -exec chmod ug=rwx,o= '{}' \; ; find ${d} -type f -exec chmod ug=rw,o= '{}' \; ; done"'
alias fixFilesystemDebianDrupal='sudo sh -c "chown -R $(whoami):33 $PWD && for d in ./sites/*/files; do find ${d} -type d -exec chmod ug=rwx,o= '{}' \; ; find ${d} -type f -exec chmod ug=rw,o= '{}' \; ; done"'

# Git
#####
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gs='git status'

# Laravel filesystem permissions.
#################################
alias fixFilesystemAlpineLaravel='sudo sh -c "chown -R $(whoami):10000 $PWD && find storage public/direct bootstrap/cache -type d -print0 | sudo xargs -0 chmod 775 && find storage bootstrap/cache -type f -print0 | sudo xargs -0 chmod 664"'
alias fixFilesystemDebianLaravel='sudo sh -c "chown -R $(whoami):33 $PWD && find storage public/direct bootstrap/cache -type d -print0 | sudo xargs -0 chmod 775 && find storage bootstrap/cache -type f -print0 | sudo xargs -0 chmod 664"'

# Node
######
gatsby10() {
  if [ "$#" -ge 2 ]; then
    local port="${1}"
    shift 1
    docker run --rm --interactive --tty --name="gatsby-container-$port" --env="PARCEL_WORKERS=1" --env="PORT=$port" --publish $port:$port --network="local-network" --volume ~/.config:/.config --volume "$PWD":/docker-container-workdir --workdir /docker-container-workdir --user $(id -u):$(id -g) austinmaddox/docker-node:10-alpine gatsby "$@"
  else
    echo "Usage: gatsby10 <port> <commands>"
    echo "Example: gatsby10 8000 develop"
  fi
}
alias gatsby='gatsby10'

alias gulp6='docker run --rm --interactive --tty --name="gulp-container" --volume "$PWD":/docker-container-workdir --user $(id -u):$(id -g) austinmaddox/docker-node:6-alpine gulp'
alias gulp='gulp6'

alias gulp-drupal6='docker run --rm --interactive --tty --name="gulp-drupal-container" --volume $(dirname "$PWD"):/docker-container-workdir --user $(id -u):$(id -g) --workdir /docker-container-workdir/.npm austinmaddox/docker-node:6-alpine gulp'
alias gulp-drupal='gulp-drupal6'

node6() {
  if [ "$#" -ge 2 ]; then
    local port="${1}"
    shift 1
    docker run --rm --interactive --tty --name="node-js-container-$port" --env="PORT=$port" --publish $port:$port --network="local-network" --volume "$PWD":/docker-container-workdir --workdir /docker-container-workdir --user $(id -u):$(id -g) austinmaddox/docker-node:6-alpine node "$@"
  else
    echo "Usage: node6 <port> <file>"
    echo "Example: node6 8000 index.js"
  fi
}
node10() {
  if [ "$#" -ge 2 ]; then
    local port="${1}"
    shift 1
    docker run --rm --interactive --tty --name="node-js-container-$port" --env="PORT=$port" --publish $port:$port --network="local-network" --volume "$PWD":/docker-container-workdir --workdir /docker-container-workdir --user $(id -u):$(id -g) node:10.16.0-stretch node "$@"
  else
    echo "Usage: node10 <port> <file>"
    echo "Example: node10 8000 index.js"
  fi
}
node12() {
  if [ "$#" -ge 2 ]; then
    local port="${1}"
    shift 1
    docker run --rm --interactive --tty --name="node-js-container-$port" --env="PORT=$port" --publish $port:$port --network="local-network" --volume "$PWD":/docker-container-workdir --workdir /docker-container-workdir --user $(id -u):$(id -g) node:12.16.0-stretch node "$@"
  else
    echo "Usage: node12 <port> <file>"
    echo "Example: node12 8888 index.js"
  fi
}
alias node='node12'

alias npm6='docker run --rm --interactive --tty --name="npm-container" --volume "$PWD":/docker-container-workdir --volume ~/.config:/.config --volume ~/.npm:/.npm --workdir /docker-container-workdir --user $(id -u):$(id -g) austinmaddox/docker-node:6-alpine npm'
npm10() {
  if [ "$#" -ge 2 ]; then
    # Note: the ~/.npmrc file must exist first or else Docker will mount and create it as a directory. Run `touch ~/.npmrc` first.
    local port="${1}"
    shift 1
    docker run --rm --interactive --tty --name="npm-container-$port" --env="PORT=$port" --env="NPM_TOKEN=blank" --publish $port:$port --network="local-network" --volume ~/.cache:/.cache --volume ~/.config:/.config --volume ~/.gitconfig:/.gitconfig --volume ~/.npm:/.npm --volume ~/.npmrc:/.npmrc --volume "$PWD":/docker-container-workdir --workdir /docker-container-workdir --user $(id -u):$(id -g) node:10.16.0-stretch npm "$@"
  else
    echo "Usage: npm10 <port> <commands>"
    echo "Example: npm10 8000 run start"
  fi
}
npm12() {
  if [ "$#" -ge 2 ]; then
    # Note: the ~/.npmrc file must exist first or else Docker will mount and create it as a directory. Run `touch ~/.npmrc` first.
    local port="${1}"
    shift 1
    docker run --rm --interactive --tty --name="npm-container-$port" --env="PORT=$port" --env="NPM_TOKEN=blank" --publish $port:$port --network="local-network" --volume ~/.cache:/.cache --volume ~/.config:/.config --volume ~/.gitconfig:/.gitconfig --volume ~/.npm:/.npm --volume ~/.npmrc:/.npmrc --volume "$PWD":/docker-container-workdir --workdir /docker-container-workdir --user $(id -u):$(id -g) node:12.16.0-stretch npm "$@"
  else
    echo "Usage: npm12 <port> <commands>"
    echo "Example: npm12 8888 run start"
  fi
}
alias npm='npm12'

npx10() {
  if [ "$#" -ge 2 ]; then
    local port="${1}"
    shift 1
    docker run --rm --interactive --tty --name="npx-container-$port" --env="PORT=$port" --publish $port:$port --network="local-network" --volume ~/.cache:/.cache --volume ~/.config:/.config --volume ~/.npm:/.npm --volume ~/.yarn:/.yarn --volume ~/.yarnrc:/.yarnrc --volume "$PWD":/docker-container-workdir --workdir /docker-container-workdir --user $(id -u):$(id -g) austinmaddox/docker-node:10-alpine npx "$@"
  else
    echo "Usage: npx10 <port> <commands>"
    echo "Example: npx10 8000 gatsby develop"
  fi
}
npx12() {
  if [ "$#" -ge 2 ]; then
    local port="${1}"
    shift 1
    docker run --rm --interactive --tty --name="npx-container-$port" --env="PORT=$port" --publish $port:$port --network="local-network" --volume ~/.cache:/.cache --volume ~/.config:/.config --volume ~/.npm:/.npm --volume ~/.yarn:/.yarn --volume ~/.yarnrc:/.yarnrc --volume "$PWD":/docker-container-workdir --workdir /docker-container-workdir --user $(id -u):$(id -g) node:12.16.0-stretch npx "$@"
  else
    echo "Usage: npx12 <port> <commands>"
    echo "Example: npx12 8888 gatsby develop"
  fi
}
alias npx='npx12'

parcel10() {
  if [ "$#" -ge 2 ]; then
    local port="${1}"
    local hmr_port=$((port + 1))
    shift 1
    docker run --rm --interactive --tty --name="parcel-container-$port" --env="PORT=$port" --env="PARCEL_WORKERS=1" --publish $port:$port --publish $hmr_port:$hmr_port --network="local-network" --volume "$PWD":/docker-container-workdir --volume ~/.cache:/.cache --workdir /docker-container-workdir --user $(id -u):$(id -g) austinmaddox/docker-node:10-alpine parcel --port $port --hmr-port $hmr_port "$@"
  else
    echo "Usage: parcel10 <port> <any other args>"
    echo "Example: parcel10 8000 src/index.html"
  fi
}
alias parcel='parcel10'

yarn10() {
  if [ "$#" -ge 2 ]; then
    # Note: the ~/.yarnrc file must exist first or else Docker will mount and create it as a directory. Run `touch ~/.yarnrc` first.
    local port="${1}"
    shift 1
    docker run --rm --interactive --tty --name="yarn-container-$port" --env="PORT=$port" --publish $port:$port --network="local-network" --volume "$PWD":/docker-container-workdir --volume ~/.cache:/.cache --volume ~/.config:/.config --volume ~/.yarn:/.yarn --volume ~/.yarnrc:/.yarnrc --workdir /docker-container-workdir --user $(id -u):$(id -g) austinmaddox/docker-node:10-alpine yarn --ignore-optional "$@"
  else
    echo "Usage: yarn10 <port> <file>"
    echo "Example: yarn10 8000 index.js"
    echo "Example: yarn10 8888 add prettier --dev"
  fi
}
alias yarn='yarn10'

# PHP
#####
alias art='php artisan'
alias composer='docker run --rm --interactive --tty --name="composer-container" --network="local-network" --volume ~/.composer:/.composer --volume "$PWD":/docker-container-workdir --workdir /docker-container-workdir --user $(id -u):$(id -g) composer:1.9.1 composer'
alias php71='docker run --rm --interactive --tty --name="php71-container" --network="local-network" --volume "$PWD":/docker-container-workdir --workdir /docker-container-workdir --user $(id -u):$(id -g) austinmaddox/docker-php:7.1-alpine php'
alias php72='docker run --rm --interactive --tty --name="php72-container" --network="local-network" --volume "$PWD":/docker-container-workdir --workdir /docker-container-workdir --user $(id -u):$(id -g) austinmaddox/docker-php:7.2-alpine php'
alias php='php72'
alias pv='php -v'

# phpserver 8000 public
phpserver() {
  local port="${1:-8000}"
  local path="${2:-.}"
  (sleep 1 && open "http://localhost:${port}")&
  docker run --rm --interactive --tty --name="php-built-in-development-web-server-$port" --publish $port:$port --network="local-network" --volume "$PWD":/docker-container-workdir --workdir /docker-container-workdir --user $(id -u):$(id -g) php:7.2-alpine php -S 0.0.0.0:$port -t $path
}
alias phpunit='php vendor/bin/phpunit -d memory_limit=2048M'
alias p='phpunit'
alias pf='phpunit --filter'

# Python
########
pythonserver() {
  local port="${1:-8000}"
  (sleep 1 && open "http://localhost:${port}")&
  python -m SimpleHTTPServer $port
}

# Terraform
###########
alias terraform='docker run --rm --interactive --tty --name="terraform-container" --env="AWS_SDK_LOAD_CONFIG=1" --env="AWS_SHARED_CREDENTIALS_FILE=/root/.aws/credentials" --volume ~/.ssh/id_rsa:/root/.ssh/id_rsa --volume ~/.terraformrc:/root/.terraformrc --volume "$PWD":/docker-container-workdir --volume ~/p/Klowd/terraform-aws-mfa-tool/.aws/freemanio-datalake-dev/credentials:/root/.aws/credentials --workdir="/docker-container-workdir" hashicorp/terraform:0.12.18'
alias tf='terraform'

alias wscat='docker run -it --rm joshgubler/wscat'
