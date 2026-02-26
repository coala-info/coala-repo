---
name: sevenbridges-python
description: The sevenbridges-python tool provides a programmatic interface for managing resources and automating bioinformatics workflows on Seven Bridges genomics platforms. Use when user asks to manage project files, query datasets, initialize API connections, or monitor analysis tasks.
homepage: https://github.com/sbg/sevenbridges-python
---


# sevenbridges-python

## Overview
The `sevenbridges-python` skill provides a specialized interface for interacting with Seven Bridges genomics platforms. It allows for the programmatic management of cloud-based bioinformatics resources, enabling users to automate repetitive tasks such as querying large datasets, managing project files, and retrieving analysis results without using the web interface.

## Authentication and Initialization
To interact with the API, you must provide an authentication token and the specific API endpoint for the environment you are using.

### API Endpoints
- **Seven Bridges Platform**: `https://api.sbgenomics.com/v2`
- **Cancer Genomics Cloud (CGC)**: `https://cgc-api.sbgenomics.com/v2`
- **CAVATICA**: `https://cavatica-api.sbgenomics.com/v2`

### Initialization Methods
The library supports three primary ways to initialize the API object:

1.  **Explicit Initialization**:
    ```python
    import sevenbridges as sbg
    api = sbg.Api(url='https://api.sbgenomics.com/v2', token='<YOUR_TOKEN>')
    ```

2.  **Environment Variables**:
    Set `SB_API_ENDPOINT` and `SB_AUTH_TOKEN` in your shell, then initialize:
    ```python
    api = sbg.Api()
    ```

3.  **Configuration File**:
    Create a file at `~/.sevenbridges/credentials` using the `.ini` format:
    ```ini
    [cgc]
    api_endpoint = https://cgc-api.sbgenomics.com/v2
    auth_token = <YOUR_TOKEN>
    ```
    Then load the specific profile:
    ```python
    config = sbg.Config(profile='cgc')
    api = sbg.Api(config=config)
    ```

## Common Usage Patterns

### User and Project Management
Retrieve your own profile information or list available projects:
```python
# Get current user details
user = api.users.me()

# Query projects with a limit to manage response size
projects = api.projects.query(limit=50)
```

### File Operations
Access files within a specific project:
```python
# Select the first project from the query
project = projects[0]

# List files associated with the project
files = project.get_files()

# Search for specific files (supported in version 2.11.0+)
# files = api.files.query(project=project.id, names=['sample1.fastq'])
```

### Task Management
Monitor or create analysis tasks:
```python
# Example: Adding output location when creating a task (v2.9.0+)
# task = api.tasks.create(name="MyTask", project=project.id, app=app_id, inputs=inputs, output_location=output_folder_id)
```

## Expert Tips and Best Practices
- **Pagination**: Always use the `limit` and `offset` parameters when querying resources (projects, files, tasks) to avoid timeouts and manage memory usage when dealing with thousands of items.
- **Profile Switching**: Use the credentials file method if you frequently switch between the CGC and the main Seven Bridges Platform. This prevents hardcoding sensitive tokens in scripts.
- **Error Handling**: Be prepared to handle `BadRequest` or connection issues. Check the error message for specific API feedback regarding missing parameters or invalid IDs.
- **Async Jobs**: For long-running operations, check for the `href` property on `AsyncJob` models (v2.11.1+) to track progress.

## Reference documentation
- [SevenBridges Python Api bindings](./references/github_com_sbg_sevenbridges-python.md)
- [sevenbridges-python - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_sevenbridges-python_overview.md)