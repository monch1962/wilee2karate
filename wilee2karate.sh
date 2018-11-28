#!/bin/bash

# Lots of features yet to be implemented, but this should be a reasonable
# starting point for converting a set of wilee tests cases into Karate format
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

INPUT=$(echo $(cat))
DESCRIPTION=$(echo $INPUT | 
    jq '.test_info.description' |
    sed 's/^.//' |
    sed 's/.$//')

URL=$(echo $INPUT |
    jq '.request.url')

METHOD=$(echo $INPUT |
    jq '.request.verb' |
    sed 's/^.//' |
    sed 's/.$//' |
    tr A-Z a-z)

REQUEST_BODY=$(echo $INPUT |
    jq '.request.body')

STATUS=$(echo $INPUT |
    jq '.expect.http_code')

RESPONSE_BODY=$(echo $INPUT |
    jq '.expect.body')

echo "Scenario: $DESCRIPTION"
echo ""
echo "Given url $URL"
if [ $REQUEST_BODY != 'null' ]; then echo "And request $REQUEST_BODY"; fi
echo "When method $METHOD"
echo "Then status $STATUS"
if [ $RESPONSE_BODY != 'null' ]; then echo "And match response == $RESPONSE_BODY"; fi
