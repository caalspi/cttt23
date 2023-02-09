#!/bin/sh

SP_APP_ID="<app_id>"
SP_TENANT_ID="<tenant_id>"
SP_CERT_LOCATION="cert.pem"

# Setting default values
APP_NAME="cttt-demo-20230210"
LOCATION="westeurope"

while getopts n:l: flag
do
    case "${flag}" in
        n) APP_NAME=${OPTARG};;
        l) LOCATION=${OPTARG};;
    esac
done

RG_NAME="rg-"$APP_NAME

az login --service-principal -u $SP_APP_ID -p $SP_CERT_LOCATION --tenant $SP_TENANT_ID

az group create --name $RG_NAME --location $LOCATION

az deployment group create -c --resource-group $RG_NAME --template-file 'main.bicep' --parameters applicationName=$APP_NAME --mode 'Complete'