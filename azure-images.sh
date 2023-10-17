#!/usr/bin/env bash
set -e

set_vars() {
  DOCKER_IMAGE_NAME=azure-images
  DOCKER_IMAGE_TAG=latest
  DOCKER_IMAGE_FULLNAME=${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
  ENV_VARS_OUTPUT=env_file.txt
}

build_image() {
  export DOCKER_BUILDKIT=1
  docker build . -t "$DOCKER_IMAGE_FULLNAME"
}

generate_env_file() {
  truncate -s 0 "$ENV_VARS_OUTPUT"
  if [[ "$ARM_CLIENT_ID" ]]; then echo "ARM_CLIENT_ID=$ARM_CLIENT_ID" >> $ENV_VARS_OUTPUT; fi
  if [[ "$ARM_CLIENT_SECRET" ]]; then echo "ARM_CLIENT_SECRET=$ARM_CLIENT_SECRET" >> $ENV_VARS_OUTPUT; fi
  if [[ "$ARM_SUBSCRIPTION_ID" ]]; then echo "ARM_SUBSCRIPTION_ID=$ARM_SUBSCRIPTION_ID" >> $ENV_VARS_OUTPUT; fi
  if [[ "$ARM_TENANT_ID" ]]; then echo "ARM_TENANT_ID=$ARM_TENANT_ID" >> $ENV_VARS_OUTPUT; fi
  if [[ "$RESOURCE_GROUP_NAME" ]]; then echo "RESOURCE_GROUP_NAME=$RESOURCE_GROUP_NAME" >> $ENV_VARS_OUTPUT; fi
  if [[ "$SERVER_SIZE" ]]; then echo "SERVER_SIZE=$SERVER_SIZE" >> $ENV_VARS_OUTPUT; fi
  if [[ "$ADMIN_PASSWORD" ]]; then echo "ADMIN_PASSWORD=$ADMIN_PASSWORD" >> $ENV_VARS_OUTPUT; fi
  if [[ "$ADMIN_USERNAME" ]]; then echo "ADMIN_USERNAME=$ADMIN_USERNAME" >> $ENV_VARS_OUTPUT; fi
  if [[ "$STORAGE_ACCOUNT_NAME" ]]; then echo "STORAGE_ACCOUNT_NAME=$STORAGE_ACCOUNT_NAME" >> $ENV_VARS_OUTPUT; fi
  if [[ "$STORAGE_CONTAINER_NAME" ]]; then echo "STORAGE_CONTAINER_NAME=$STORAGE_CONTAINER_NAME" >> $ENV_VARS_OUTPUT; fi
  if [[ "$ALLOWED_IPS" ]]; then echo "ALLOWED_IPS=$ALLOWED_IPS" >> $ENV_VARS_OUTPUT; fi
  if [[ "$AMOUNT" ]]; then echo "AMOUNT=$AMOUNT" >> $ENV_VARS_OUTPUT; fi
}

run_command() {
  case "$1" in
  create)
    docker run \
    --init \
    --rm \
    --env-file "$ENV_VARS_OUTPUT" \
    "$DOCKER_IMAGE_NAME" commands/create "$@"
    ;;
  delete)
    docker run \
    --init \
    --rm \
    --env-file "$ENV_VARS_OUTPUT" \
    "$DOCKER_IMAGE_NAME" commands/delete "$@"
    ;;
  esac

  DOCKER_RUN_PID=$!
  abort_handler() {
    kill -15 ${DOCKER_RUN_PID}
  }
  rm "$ENV_VARS_OUTPUT"
  trap 'abort_handler' SIGTERM TERM HUP INT
  wait ${DOCKER_RUN_PID}

  exit_code=$?
  echo "Script finished with exit code: $exit_code"
  exit $exit_code
}
main() {
  set_vars
  build_image
  generate_env_file
  run_command "$@"
}

main "$@"
