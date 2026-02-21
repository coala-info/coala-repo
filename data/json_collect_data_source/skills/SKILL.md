---
name: json_collect_data_source
description: The `json_collect_data_source` tool serves as an advanced data provider that extends the capabilities of standard JSON data sources.
homepage: https://github.com/fabio-cumbo/galaxy-json-collect-data-source
---

# json_collect_data_source

## Overview
The `json_collect_data_source` tool serves as an advanced data provider that extends the capabilities of standard JSON data sources. It is primarily used to automate the retrieval of multiple files in a single operation. By processing JSON queries that point to remote or local resources, it can unpack various archive formats and automatically organize the resulting files into a coherent collection, making it ideal for high-throughput data staging and complex metadata handling.

## Command Line Usage
The tool is typically invoked via the command line to process a JSON input file containing the data source specifications.

### Basic Execution
```bash
json_collect_data_source <input_json_file>
```

### Input JSON Structure
The input JSON should define the datasets to be collected. While specific schemas can vary based on the target environment, the core logic follows these patterns:
- **URL/Path**: Specify the location of the data.
- **Metadata**: Include associated key-value pairs for the datasets.
- **Archive Handling**: If the source is an archive (e.g., `.tar.gz` or `.zip`), the tool will iterate through the contents.

## Best Practices
- **Archive Preparation**: Ensure archives are not nested deeper than necessary, as the tool is optimized for extracting contents into a flat or structured collection based on the archive's internal hierarchy.
- **Compression Formats**: Use `.gz` or `.bz2` for single large files and `.tar` or `.zip` when grouping multiple related datasets.
- **Metadata Mapping**: When providing metadata within the JSON query, ensure keys match the expected attributes of the downstream analysis tools to maintain data integrity throughout the workflow.

## Reference documentation
- [json_collect_data_source Overview](./references/anaconda_org_channels_bioconda_packages_json_collect_data_source_overview.md)