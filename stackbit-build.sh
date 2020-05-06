#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://api.stackbit.com/project/5eb2d463bc9011001b478fbf/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://api.stackbit.com/pull/5eb2d463bc9011001b478fbf 
fi
curl -s -X POST https://api.stackbit.com/project/5eb2d463bc9011001b478fbf/webhook/build/ssgbuild > /dev/null
gatsby build
curl -s -X POST https://api.stackbit.com/project/5eb2d463bc9011001b478fbf/webhook/build/publish > /dev/null
