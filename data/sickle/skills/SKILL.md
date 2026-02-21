---
name: sickle
description: Sickle is a lightweight Python library designed to make OAI-PMH harvesting "human-friendly." It abstracts the complexities of the OAI-PMH protocol—such as handling HTTP requests, managing resumption tokens for pagination, and parsing XML responses—into a clean, Pythonic API.
homepage: http://github.com/mloesch/sickle
---

# sickle

## Overview
Sickle is a lightweight Python library designed to make OAI-PMH harvesting "human-friendly." It abstracts the complexities of the OAI-PMH protocol—such as handling HTTP requests, managing resumption tokens for pagination, and parsing XML responses—into a clean, Pythonic API. Use this skill to automate the collection of metadata from any OAI-compliant repository.

## Usage Patterns

### Basic Harvesting
To begin harvesting, initialize the `Sickle` object with the repository's OAI interface URL.

```python
from sickle import Sickle

# Initialize the client
sickle = Sickle('http://example.edu/oai2')

# List records using a specific metadata format
records = sickle.ListRecords(metadataPrefix='oai_dc')

# Iterate through records (Sickle handles resumption tokens automatically)
for record in records:
    print(record.header.identifier)
    # Access metadata as a dictionary
    print(record.metadata)
```

### Supported OAI Verbs
Sickle supports all six OAI-PMH verbs as method calls:
- `Identify()`: Retrieve repository information.
- `ListMetadataFormats()`: List available metadata formats (e.g., oai_dc).
- `ListSets()`: Retrieve the set structure of the repository.
- `ListIdentifiers(metadataPrefix='...')`: Retrieve only record headers.
- `ListRecords(metadataPrefix='...')`: Retrieve full records.
- `GetRecord(identifier='...', metadataPrefix='...')`: Retrieve a specific record.

### Filtering and Parameters
You can pass standard OAI-PMH arguments as keyword arguments to the verb methods:
- `from`: Starting date (UTC).
- `until`: Ending date (UTC).
- `set`: The spec of the set to harvest.
- `metadataPrefix`: The metadata format (required for most list operations).

```python
# Harvest a specific set within a date range
records = sickle.ListRecords(
    metadataPrefix='oai_dc',
    set='biology',
    **{'from': '2023-01-01T00:00:00Z'} # Use dict unpacking for reserved keywords like 'from'
)
```

## Expert Tips and Best Practices

### Handling Deleted Items
By default, OAI-PMH responses may include headers for deleted items. You can configure Sickle to ignore these during iteration to avoid processing empty metadata shells.
```python
sickle = Sickle('http://example.edu/oai2', ignore_deleted=True)
```

### Customizing HTTP Behavior
Sickle uses the `requests` library. You can pass arbitrary arguments to the underlying request (like timeouts or authentication) via the `request_args` parameter.
```python
sickle = Sickle('http://example.edu/oai2', request_args={'timeout': 30, 'verify': False})
```

### Dealing with Large Trees
For repositories with extremely large XML payloads, ensure your environment can handle deep XML parsing. Sickle uses `lxml` for performance, but you should monitor memory usage when iterating over millions of records in a single session.

### Metadata De-serialization
Sickle automatically converts Dublin Core (oai_dc) metadata into Python dictionaries. For other formats, you may need to access the raw XML via `record.raw` or `record.xml` and parse it using `lxml` or `BeautifulSoup`.

## Reference documentation
- [Sickle: OAI-PMH for Humans](./references/github_com_mloesch_sickle.md)
- [Anaconda Bioconda Sickle Overview](./references/anaconda_org_channels_bioconda_packages_sickle_overview.md)