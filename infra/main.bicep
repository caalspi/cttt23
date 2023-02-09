targetScope = 'resourceGroup'

// Required params
@description('Application name. Will be used as a suffix to the name of each resource')
param applicationName string

// Optional params
@description('Location of resources. Default is location of resource group')
param location string = resourceGroup().location

/*
* General resources
*/
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  kind: 'StorageV2'
  location: location
  name: 'st${replace(applicationName, '-', '')}'
  sku: {
    name: 'Standard_ZRS'
  }
}

/*
* Cognitive Services
*/
resource languageService 'Microsoft.CognitiveServices/accounts@2022-10-01' = {
  kind: 'TextAnalytics'
  name: 'cog-ta-${applicationName}'
  location: location
  sku: {
    name: 'F0'
  }
  properties: {
    apiProperties:{}
    publicNetworkAccess: 'Enabled'
  }
}

resource translator 'Microsoft.CognitiveServices/accounts@2022-10-01' = {
  kind: 'TextTranslation'
  name: 'cog-tt-${applicationName}'
  location: location
  sku: {
    name: 'F0'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource contentModerator 'Microsoft.CognitiveServices/accounts@2022-10-01' = {
  kind: 'ContentModerator'
  name: 'cog-cm-${applicationName}'
  location: location
  sku: {
    name: 'F0'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

resource speechService 'Microsoft.CognitiveServices/accounts@2022-10-01' = {
  kind: 'SpeechServices'
  name: 'cog-speech-${applicationName}'
  location: location
  sku: {
    name: 'F0'
  }
  properties: {
    publicNetworkAccess: 'Enabled'
  }
}

// /*
// * Applied AI + required resources
// */
// resource mediaService 'Microsoft.Media/mediaservices@2021-11-01' = {
//   location: location
//   name: 'ms${replace(applicationName, '-', '')}'
//   properties: {
//     encryption: {
//       type: 'SystemKey'
//     }
//     keyDelivery: {
//       accessControl: {
//         defaultAction: 'Allow'
//         ipAllowList: []
//       }
//     }
//     publicNetworkAccess: 'Enabled'
//     storageAccounts: [
//       {
//         id: storageAccount.id
//         type: 'Primary'
//       }
//     ]
//     storageAuthentication: 'System'
//   }

//   resource streamingEndpoint 'streamingEndpoints' = {
//     location: location
//     name: 'default'
//     properties: {
//       cdnEnabled: false
//       scaleUnits: 0
//     }
//     sku: {
//       capacity: 0
//     }
//   }  
// }

// resource videoIndexer 'Microsoft.VideoIndexer/accounts@2022-08-01' = {
//   identity: {
//     type: 'SystemAssigned'
//   }
//   location: location
//   name: 'cog-vid-${applicationName}'
//   properties: {
//     accountId: 'cd6694eb-0931-4ecf-9f17-37b637afb8f3'
//     mediaServices: {
//       resourceId: mediaService.id
//     }
//   }
// }
