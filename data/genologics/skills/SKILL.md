---
name: genologics
description: The genologics library provides a Pythonic interface to interact with the GenoLogics LIMS REST API for managing laboratory information. Use when user asks to query, create, or update LIMS entities such as projects, samples, and artifacts.
homepage: https://github.com/scilifelab/genologics
metadata:
  docker_image: "quay.io/biocontainers/genologics:0.4.1--py_0"
---

# genologics

## Overview

The `genologics` library is a Pythonic interface to the GenoLogics LIMS REST API. It allows bioinformaticians and lab automation engineers to programmatically query, create, and update LIMS entities. The library maps XML representations from the API to Python objects, using descriptors to handle attribute access and an internal cache to ensure data consistency across a single script execution.

## Configuration

Before using the library, configure your connection credentials in a `.genologicsrc` file. The library searches for this file in the current directory or the user's home directory.

**File format (`.genologicsrc`):**
```ini
[genologics]
BASEURI=https://your-lims-server.com:8443
USERNAME=api_user
PASSWORD=api_password

[logging]
MAIN_LOG=/path/to/your/logfile.log
```

## Core Usage Patterns

### Initializing the Connection
Always use the `Lims` class to establish a session. It manages the connection pool and the object cache.

```python
from genologics.lims import Lims
from genologics.config import BASEURI, USERNAME, PASSWORD

# Initialize the LIMS instance
lims = Lims(BASEURI, USERNAME, PASSWORD)
```

### Accessing Entities
Use the `get_*` methods provided by the `Lims` instance. These methods return lists or specific instances and utilize the internal cache.

*   **Retrieve all projects:** `projects = lims.get_projects()`
*   **Retrieve a specific sample by ID:** `sample = Sample(lims, id="LIMS_ID")`
*   **Search for samples by name:** `samples = lims.get_samples(name="SampleName")`

### Lazy Loading and Data Access
Entities (Project, Sample, Artifact, Process, etc.) are loaded lazily. The XML data is only fetched from the server when you access an attribute for the first time.

```python
# This only creates the object shell
sample = lims.get_samples(name="MySample")[0]

# This triggers the REST API call to fetch XML
print(sample.date_received)

# Accessing User Defined Fields (UDFs)
print(sample.udf['Concentration'])
```

### Updating Entities
To modify data, update the object attributes or the `udf` dictionary, then call the `put()` method.

```python
sample.udf['Status'] = 'Passed'
sample.put()
```

## Best Practices and Expert Tips

1.  **Singleton Pattern for Entities:** Avoid creating multiple instances of the same LIMS entity (e.g., the same Sample ID) manually. Always prefer using `lims.get_samples()` or similar methods to ensure the internal cache maintains a single source of truth for that object during your script's lifecycle.
2.  **Artifact State Handling:** Be aware that Artifact URLs often include state as a query parameter. The library's cache may treat `.../artifacts/123` and `.../artifacts/123?state=456` as different objects. Always verify you are working with the intended state.
3.  **Batching:** When processing many entities, minimize API overhead by fetching lists of entities first, then accessing their attributes.
4.  **Descriptor Access:** Predefined attributes (like `sample.name` or `project.open_date`) are handled via descriptors that map directly to the underlying ElementTree. Modifying these directly updates the XML structure used for `put()`.

## Reference documentation
- [Python interface to the GenoLogics LIMS server](./references/github_com_scilifelab_genologics.md)
- [genologics - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_genologics_overview.md)