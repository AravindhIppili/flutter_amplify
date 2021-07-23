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
                            "PoolId": "us-east-2:74e37bef-a428-42cf-8be9-96f6ef6a5961",
                            "Region": "us-east-2"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-2_tIDepRlMB",
                        "AppClientId": "1h2g62s14p4ifed237kj7ef77t",
                        "Region": "us-east-2"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "awsauth79c0a643be6c4b95ba35423f8132f8f2142307-dev",
                        "Region": "us-east-2"
                    }
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "awsauth79c0a643be6c4b95ba35423f8132f8f2142307-dev",
                "region": "us-east-2",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';