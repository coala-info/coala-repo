---
name: sparql-query-in-a-file-on-graph-database
description: "This Common Workflow Language workflow executes a SPARQL query from a local file against a remote graph database endpoint to extract structured data from RDF repositories. Use this skill when you need to retrieve specific biological annotations, integrate disparate datasets from linked data sources, or characterize molecular entities using knowledge graphs."
homepage: https://workflowhub.eu/workflows/122
---
# SPARQL query (in a file) on graph database

## Overview

This Common Workflow Language (CWL) workflow executes SPARQL queries against a specified graph database endpoint. Rather than requiring manual query entry, the workflow automates the process by reading the SPARQL command directly from a provided input file, ensuring consistency and reproducibility for complex data retrieval tasks.

The workflow is designed to interface with any accessible RDF triplestore that supports standard SPARQL protocol requests. It handles the connection to the database, submits the query file, and captures the resulting dataset for use in downstream analysis steps.

Detailed metadata, version history, and the source implementation can be found on the [WorkflowHub page](https://workflowhub.eu/workflows/122). The tool is distributed under the Apache-2.0 license, making it suitable for integration into both open-source and commercial data pipelines.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| query_file |  | File |  |
| endpoint |  | string |  |


## Steps

_Step list is not in the RO-Crate metadata; open the main workflow CWL below or see WorkflowHub for the diagram._


## Outputs

_None listed._


## Files

- WorkflowHub: https://workflowhub.eu/workflows/122
- `sparql-query.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata
