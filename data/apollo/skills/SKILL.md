---
name: apollo
description: The `apollo` skill enables programmatic interaction with the Apollo genome annotation platform.
homepage: https://github.com/galaxy-genome-annotation/python-apollo
---

# apollo

## Overview
The `apollo` skill enables programmatic interaction with the Apollo genome annotation platform. While Apollo provides a web interface for manual annotation, this tool is essential for administrators and bioinformaticians who need to automate the setup of new organisms, manage large sets of user permissions, or integrate Apollo into data processing pipelines. It consists of a Python library (`apollo`) for script-based logic and a companion CLI tool (`arrow`) for shell-based operations.

## Installation and Setup
Install the package via pip or conda:
```bash
pip install apollo
# OR
conda install -c bioconda apollo
```

Before using the CLI, initialize your connection settings:
```bash
arrow init
```
This creates a configuration file that stores your Apollo instance URL and credentials, allowing you to run commands without re-authenticating every time.

## CLI Best Practices (Arrow)
The `arrow` CLI is most effective when combined with standard Unix utilities like `jq` for filtering JSON responses.

### User and Group Management
To perform bulk operations, pipe the output of `get_users` into `jq` to filter by specific criteria (e.g., email domain) and then pass the results back to `arrow`.

**Example: Adding all users from a specific domain to a group**
```bash
arrow users get_users | \
jq -r '.[] | select(.username | contains("@institution.edu")) | .username' | \
xargs -n1 arrow users add_to_group "target_group_name"
```

### Organism Management
When adding or updating organisms, use the `--suppress_output` flag if you are running these in a loop to keep logs clean, or use specific flags for metadata:
```bash
arrow organisms add_organism "Organism_Name" "/path/to/jbrowse/data" --genus "Genus" --species "species"
```

## Python Library Patterns
Use the Python library for complex workflows that require conditional logic or error handling.

### Initializing the Client
You can either provide credentials directly or load them from the `arrow` configuration:
```python
from apollo import ApolloInstance
from arrow.apollo import get_apollo_instance

# Method 1: Explicit credentials
wa = ApolloInstance('https://apollo.url', 'user@domain.edu', 'password')

# Method 2: Use existing arrow config (Recommended)
wa = get_apollo_instance()
```

### Handling Asynchronous Processing
Apollo often processes organism additions in the background. When writing scripts that create an organism and immediately modify its permissions, include a short delay to ensure the database has updated.

```python
import time

# Add organism
wa.organisms.add_organism("Yeast", "/data/jbrowse")

# Wait for Apollo to process the new entry
time.sleep(1)

# Update permissions
wa.users.update_organism_permissions("user@domain.edu", "Yeast", write=True, read=True)
```

## Expert Tips
- **GFF3 Loading**: Use `load_gff3` for bulk annotation uploads. Recent versions (4.2.2+) are significantly faster and better at handling non-coding types and CDS calculations.
- **Credential Security**: Avoid hardcoding passwords in scripts. Use `get_apollo_instance()` to leverage the local encrypted or protected config created by `arrow init`.
- **API Responses**: If an API response seems to be missing data, check your version. Version 4.2.12 fixed an issue where usernames were occasionally filtered out of responses.

## Reference documentation
- [Python library for talking to Apollo API](./references/github_com_galaxy-genome-annotation_python-apollo.md)
- [Apollo Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_apollo_overview.md)