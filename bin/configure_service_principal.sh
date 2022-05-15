#!/bin/bash

export AZURE_SP=xxx
export AZURE_SUBSCRIPTION_ID=xxx

principal=$(az ad sp create-for-rbac --scope "/subscriptions/$AZURE_SUBSCRIPTION_ID" --role Contributor --sdk-auth -n $AZURE_SP)

echo $principal
