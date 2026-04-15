---
name: botocore
description: Botocore is a low-level Python library that provides the foundational core functionality for interacting with Amazon Web Services. Use when user asks to manage AWS credentials, perform raw service requests, use paginators or waiters, or minimize memory overhead compared to high-level SDKs.
homepage: https://github.com/boto/botocore
metadata:
  docker_image: "quay.io/biocontainers/botocore:1.3.6--py35_0"
---

# botocore

## Overview

Botocore is the foundational library that powers both Boto3 and the AWS CLI. It provides the low-level core functionality required to interact with Amazon Web Services, including credential management, request signing, and service model mapping. While Boto3 offers high-level "resource" abstractions, Botocore focuses on a data-driven approach where service descriptions are loaded from JSON models. Use this skill when you need to minimize memory overhead, require precise control over HTTP requests, or are developing tools that need to remain closely aligned with the raw AWS service APIs.

## Core Usage Patterns

### Initializing a Session and Client
The entry point for Botocore is the session, which manages configuration and state.

```python
import botocore.session

# Create a session
session = botocore.session.get_session()

# Create a low-level client for a specific service
client = session.create_client('s3', region_name='us-east-1')

# Execute a command (returns a dictionary of the raw response)
response = client.list_buckets()
```

### Handling Credentials
Botocore looks for credentials in a specific order: environment variables, config files, and IAM roles. You can manually provide credentials if necessary:

```python
client = session.create_client(
    'ec2',
    aws_access_key_id='ACCESS_KEY',
    aws_secret_access_key='SECRET_KEY',
    region_name='us-west-2'
)
```

### Low-Level Error Handling
Botocore exceptions are found in `botocore.exceptions`. Unlike high-level libraries, you often need to parse the `Error` code from the response dictionary for specific service errors.

```python
from botocore.exceptions import ClientError

try:
    response = client.describe_instances(InstanceIds=['i-1234567890abcdef0'])
except ClientError as e:
    if e.response['Error']['Code'] == 'InvalidInstanceID.NotFound':
        print("Instance does not exist.")
    else:
        raise e
```

## Expert Tips and Best Practices

- **Use Paginators for Large Data Sets**: Many AWS operations return truncated results. Use Botocore's built-in paginators to handle the token logic automatically.
  ```python
  paginator = client.get_paginator('list_objects_v2')
  for page in paginator.paginate(Bucket='my-bucket'):
      print(page['Contents'])
  ```
- **Leverage Waiters**: Instead of writing custom sleep loops, use Waiters to poll for resource states (e.g., waiting for an EC2 instance to be 'running').
  ```python
  waiter = client.get_waiter('instance_running')
  waiter.wait(InstanceIds=['i-12345'])
  ```
- **Event System**: Botocore has a powerful event system (`before-call`, `after-call`) that allows you to inject custom logic or headers into requests without modifying the core library.
- **Minimize Imports**: If you only need low-level access, importing `botocore` instead of `boto3` can reduce the memory footprint of your application, which is particularly useful in AWS Lambda environments.

## Reference documentation
- [Botocore README](./references/github_com_boto_botocore.md)
- [Botocore Security Policy](./references/github_com_boto_botocore_security.md)