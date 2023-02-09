# Readme

## Get Started

### Setup Infrastructure

1) Create Service Principal with the following command

    ```bash
    az ad sp create-for-rbac --name '<service_principal_name>' \
                                    --role contributor \
                                    --scopes /subscriptions/<subscription_id> \
                                    --create-cert
    ```

    ```json
    Output
    {
    "appId": "<app_id>",
    "displayName": "<service_principal_name>",
    "fileWithCertAndPrivateKey": "<cert_location>",
    "password": null,
    "tenant": "<tenant_id>"
    }
    ```

1) Move your generated certificate form <cert_location> to the folder containing your deploy.sh script.
1) Update the variables in deploy.sh and run the following command to deploy the resources
    > ⚠️**WARNING**⚠️
    >
    > The deployment mode is set to '**Complete**'. This means that it will remove all resources that are not specified in the main.bicep file

    ```bash
    ./deploy.sh -n '<application_name>' -l '<location>'
    ```


## Resources

### Infra (Biceps)

- [Cognitive Services](https://learn.microsoft.com/en-us/azure/cognitive-services/create-account-bicep?tabs=CLI)
