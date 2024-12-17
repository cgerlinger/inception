#! /bin/bash

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

ENV_FILE=srcs/.env
REQUIRED_VARS=(
	DB_NAME
	DB_USER
	DB_PASSWORD
	DB_ROOT_PASSWORD
	DB_HOST
	DOMAIN_NAME
	TITLE
	ADMIN_USER
	ADMIN_PASSWORD
	ADMIN_EMAIL
	USER
	USER_EMAIL
	USER_PASSWORD
)

# Check if the .env file exists
if [ ! -f "$ENV_FILE" ]; then
	echo -e "${RED}Error:${NC} .env file not found"
	exit 1
fi

source "$ENV_FILE"

for var in "${REQUIRED_VARS[@]}"; do
	# Check if the variable is present in the .env file
	if ! grep -q "^${var}=" "$ENV_FILE"; then
		echo -e "${RED}Error:${NC} $var is missing in .env file"
		exit 1
	fi

	# Check if the variable is not empty
	if grep -q "^${var}=$" "$ENV_FILE"; then
		echo -e "${RED}Error:${NC} $var is not set in .env file"
		exit 1
	fi
done


# Validate admin username
admin_user=$(eval echo "\$ADMIN_USER")
admin_user_lower=$(echo "$admin_user" | tr '[:upper:]' '[:lower:]')
if [[ "$admin_user_lower" =~ admin ]] || [[ "$admin_user_lower" =~ administrator ]]; then
	echo -e "${RED}Error:${NC} ADMIN_USER cannot contain 'admin' or 'administrator' (case insensitive)" >&2
	exit 1
fi

echo -e "${GREEN}Environment validation successful!${NC}"