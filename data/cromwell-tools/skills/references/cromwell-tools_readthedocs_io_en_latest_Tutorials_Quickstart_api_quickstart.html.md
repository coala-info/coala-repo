[Cromwell Tools](../../index.html)

latest

Overview

* [Cromwell-tools](../../README_SYMLINK.html)

Tutorials

* Cromwell-tools Python API Quickstart
  + [Standard Authentication](#Standard-Authentication)
    - [1. [Recommended] Authenticate with Cromwell using the standardized method](#1.-[Recommended]-Authenticate-with-Cromwell-using-the-standardized-method)
    - [2. Authenticate with Cromwell using HTTPBasicAuth (username and password)](#2.-Authenticate-with-Cromwell-using-HTTPBasicAuth-(username-and-password))
    - [3. Authenticate with Cromwell using HTTPBasicAuth (secret JSON file)](#3.-Authenticate-with-Cromwell-using-HTTPBasicAuth-(secret-JSON-file))
    - [4. Authenticate with Cromwell using OAuth (service account JSON key file)](#4.-Authenticate-with-Cromwell-using-OAuth-(service-account-JSON-key-file))
    - [5. Authenticate with Cromwell with no Auth](#5.-Authenticate-with-Cromwell-with-no-Auth)
  + [Submit jobs to Cromwell/Cromwell-as-a-Service](#Submit-jobs-to-Cromwell/Cromwell-as-a-Service)
  + [Query jobs in Cromwell/Cromwell-as-a-Service](#Query-jobs-in-Cromwell/Cromwell-as-a-Service)
    - [Get the workflows](#Get-the-workflows)
  + [Submit jobs with On Hold in Cromwell/Cromwell-as-a-Service](#Submit-jobs-with-On-Hold-in-Cromwell/Cromwell-as-a-Service)
    - [Submit the job](#Submit-the-job)
    - [Check the status of the job](#Check-the-status-of-the-job)
    - [Release the job](#Release-the-job)
* [Cromwell-tools Command Line Interface Quickstart](cli_quickstart.html)

API Documentation

* [API Documentation](../../API/index.html)

[Cromwell Tools](../../index.html)

* [Docs](../../index.html) »
* Cromwell-tools Python API Quickstart
* [Edit on GitHub](https://github.com/broadinstitute/cromwell-tools/blob/master/docs/Tutorials/Quickstart/api_quickstart.ipynb)

---

# Cromwell-tools Python API Quickstart[¶](#Cromwell-tools-Python-API-Quickstart "Permalink to this headline")

This notebook will help you get familiar with the Cromwell-tools’ Python API client. After walking through this notebook you should be able to import cromwell-tools in your Python application and talk to Cromwell engine using various authentication methods.

## Standard Authentication[¶](#Standard-Authentication "Permalink to this headline")

### 1. [Recommended] Authenticate with Cromwell using the standardized method[¶](#1.-[Recommended]-Authenticate-with-Cromwell-using-the-standardized-method "Permalink to this headline")

cromwell-tools provides a standard method `cromwell_tools.cromwell_auth.CromwellAuth.harmonize_credentials` to authenticate with various Cromwell instances, which is the preferred auth method.

```
[2]:
```

```
from cromwell_tools.cromwell_auth import CromwellAuth

# Authenticate with Cromwell using HTTPBasicAuth (username and password)
auth = CromwellAuth.harmonize_credentials(username='username',
                                          password='password',
                                          url='https://cromwell.xxx.broadinstitute.org')

# Authenticate with Cromwell using HTTPBasicAuth (secret JSON file)
auth_2 = CromwellAuth.harmonize_credentials(secrets_file='path/to/secrets_file.json')

# Authenticate with Cromwell using OAuth (service account JSON key file)
auth_3 = CromwellAuth.harmonize_credentials(service_account_key='path/to/service/account/key.json',
                                            url='https://cromwell.caas-prod.broadinstitute.org')

# Authenticate with Cromwell with no Auth
auth_4 = CromwellAuth.harmonize_credentials(url='https://cromwell.caas-prod.broadinstitute.org')
```

### 2. Authenticate with Cromwell using HTTPBasicAuth (username and password)[¶](#2.-Authenticate-with-Cromwell-using-HTTPBasicAuth-(username-and-password) "Permalink to this headline")

```
[37]:
```

```
from cromwell_tools.cromwell_auth import CromwellAuth

auth_httpbasic = CromwellAuth.from_user_password(username='username',
                                                 password='password',
                                                 url='https://cromwell.xxx.broadinstitute.org')
```

### 3. Authenticate with Cromwell using HTTPBasicAuth (secret JSON file)[¶](#3.-Authenticate-with-Cromwell-using-HTTPBasicAuth-(secret-JSON-file) "Permalink to this headline")

A secret JSON file should look like the following example with 3 keys:

```
{
    "url": "url",
    "username": "username",
    "password": "password"
}
```

```
[3]:
```

```
from cromwell_tools.cromwell_auth import CromwellAuth

auth_httpbasic_file = CromwellAuth.from_secrets_file(secrets_file='path/to/secrets_file.json')
```

### 4. Authenticate with Cromwell using OAuth (service account JSON key file)[¶](#4.-Authenticate-with-Cromwell-using-OAuth-(service-account-JSON-key-file) "Permalink to this headline")

```
[25]:
```

```
from cromwell_tools.cromwell_auth import CromwellAuth

auth_oauth = CromwellAuth.from_service_account_key_file(service_account_key='path/to/service/account/key.json',
                                                        url='https://cromwell.caas-prod.broadinstitute.org')
```

### 5. Authenticate with Cromwell with no Auth[¶](#5.-Authenticate-with-Cromwell-with-no-Auth "Permalink to this headline")

```
[5]:
```

```
from cromwell_tools.cromwell_auth import CromwellAuth

auth_no_auth = CromwellAuth.from_no_authentication(url='https://cromwell.caas-prod.broadinstitute.org')
```

## Submit jobs to Cromwell/Cromwell-as-a-Service[¶](#Submit-jobs-to-Cromwell/Cromwell-as-a-Service "Permalink to this headline")

```
[3]:
```

```
from cromwell_tools import api
from cromwell_tools import utilities
```

```
[4]:
```

```
response = api.submit(auth=auth,
                      wdl_file='Examples/hello_world.wdl',
                      inputs_files=['Examples/inputs.json'],
                      dependencies=['Examples/helloworld.wdl'])
```

```
[5]:
```

```
response.json()
```

```
[5]:
```

```
{'id': '2df17053-57d1-44a4-a922-efea7b29beb0', 'status': 'Submitted'}
```

```
[7]:
```

```
api.wait(workflow_ids=[response.json()['id']], auth=auth, poll_interval_seconds=3)
```

```
All workflows succeeded!
```

## Query jobs in Cromwell/Cromwell-as-a-Service[¶](#Query-jobs-in-Cromwell/Cromwell-as-a-Service "Permalink to this headline")

### Get the workflows[¶](#Get-the-workflows "Permalink to this headline")

```
[8]:
```

```
from cromwell_tools import api
from cromwell_tools import utilities
```

There are a lot of query keys can be used to filter workflows A complicated query dict could be:

```
custom_query_dict = {
    'label': {
        'cromwell-workflow-id': 'cromwell-xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
        'project_shortname': 'Name of a project that trigerred this workflow'
    },
    'status': ['Running', 'Succeeded', 'Aborted', 'Submitted', 'On Hold', 'Failed'],
    'id': 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx',
    'additionalQueryResultFields': 'labels',
    'submission': '2018-01-01T00:01:01.410150Z',
    'start': '2018-01-01T01:01:01.410150Z',
    'end': '2018-01-01T02:01:01.410150Z',
    'name': ['SmartSeq2SingleCell', '10xCount'],
    'additionalQueryResultFields': ['labels'],
    'includeSubworkflows': True
}
```

We will just use a very simple example here to query for the workflow we just submitted:

```
[9]:
```

```
custom_query_dict = {
    'name': 'HelloWorld',
    'id': response.json()['id']
}

response = api.query(query_dict=custom_query_dict, auth=auth)
```

```
[10]:
```

```
response.json()['results']
```

```
[10]:
```

```
[{'name': 'HelloWorld',
  'id': '2df17053-57d1-44a4-a922-efea7b29beb0',
  'submission': '2018-11-19T20:58:34.362Z',
  'status': 'Succeeded',
  'end': '2018-11-19T21:00:04.674Z',
  'start': '2018-11-19T20:58:45.442Z'}]
```

## Submit jobs with On Hold in Cromwell/Cromwell-as-a-Service[¶](#Submit-jobs-with-On-Hold-in-Cromwell/Cromwell-as-a-Service "Permalink to this headline")

* Submit a job with “On Hold” status.
* Check the status.
* Release the job.

### Submit the job[¶](#Submit-the-job "Permalink to this headline")

```
[11]:
```

```
from cromwell_tools import api
from cromwell_tools import utilities
```

```
[13]:
```

```
response = api.submit(auth=auth,
                      wdl_file='Examples/hello_world.wdl',
                      inputs_files=['Examples/inputs.json'],
                      dependencies=['Examples/helloworld.wdl'],
                      on_hold=True)
```

```
[14]:
```

```
response.json()
```

```
[14]:
```

```
{'id': 'a996309c-03ae-4c96-bced-63215448b0dd', 'status': 'On Hold'}
```

### Check the status of the job[¶](#Check-the-status-of-the-job "Permalink to this headline")

```
[16]:
```

```
response = api.status(auth=auth,
                      uuid=response.json()['id'])
response.json()
```

```
[16]:
```

```
{'status': 'On Hold', 'id': 'a996309c-03ae-4c96-bced-63215448b0dd'}
```

### Release the job[¶](#Release-the-job "Permalink to this headline")

```
[18]:
```

```
response = api.release_hold(auth=auth,
                            uuid=response.json()['id'])
response.json()
```

```
[18]:
```

```
{'id': 'a996309c-03ae-4c96-bced-63215448b0dd', 'status': 'Submitted'}
```

[Next](cli_quickstart.html "Cromwell-tools Command Line Interface Quickstart")
 [Previous](../../README_SYMLINK.html "Cromwell-tools")

---

© Copyright 2018, Mint Team
Revision `fb1753dd`.

Built with [Sphinx](http://sphinx-doc.org/) using a [theme](https://github.com/rtfd/sphinx_rtd_theme) provided by [Read the Docs](https://readthedocs.org).