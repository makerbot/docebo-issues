# Script to replicate the issue with Docebo on the production instance

# Token generated via /oauth2/token
DOCEBO_ACCESS_TOKEN=$1
# Docebo base API URL
DOCEBO_API_URL=https://makerbotecs.docebosaas.com/api # Reproduces issue
#DOCEBO_API_URL=https://university.makerbot.com/api # Reproduces issue
#DOCEBO_API_URL=https://makerbotsandbox.docebosaas.com/api # Does not reproduce issue


# Index of additional field to add for user
FIELD_NUM=242 # Note that it doesn't reproduce for certain field numbers (#1 did not work)

COOKIE_JAR=./cookie-jar.tmp

if [ -z ${DOCEBO_ACCESS_TOKEN} ]; then
  echo Please enter Docebo access token
  exit;
fi

# Create user without cookie header (none already exist)
# Does not persist additional fields
curl -vi -X POST \
  $DOCEBO_API_URL/user/create \
  -H "Authorization: Bearer $DOCEBO_ACCESS_TOKEN" \
  -H 'Content-Type: application/json' \
  -d "{
    \"userid\": \"docebo-test-create-user-no-cookie\",
    \"fields\": {
      \"$FIELD_NUM\": \"test\"
      }
}" \
  -c $COOKIE_JAR # Cookie is persisted here


# Create user with cookie header from the cookie jar file
# Persists the additional fields
curl -vi -X POST \
  $DOCEBO_API_URL/user/create \
  -H "Authorization: Bearer $DOCEBO_ACCESS_TOKEN" \
  -H 'Content-Type: application/json' \
  -d "{
    \"userid\": \"docebo-test-create-user-with-cookie\",
    \"fields\": {
      \"$FIELD_NUM\": \"test\"
    }
  }" \
  -b $COOKIE_JAR
