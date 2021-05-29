const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "ap-southeast-2:a4781c58-2894-414d-a6dc-9cb8b62a547f",
                            "Region": "ap-southeast-2"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "ap-southeast-2_gOduRHr2L",
                        "AppClientId": "36tpr89am33q25l1i0vc3mec4q",
                        "Region": "ap-southeast-2"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "testapp2storageamplify105321-dev",
                        "Region": "ap-southeast-2"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "testapp2storageamplify105321-dev",
                "region": "ap-southeast-2",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';