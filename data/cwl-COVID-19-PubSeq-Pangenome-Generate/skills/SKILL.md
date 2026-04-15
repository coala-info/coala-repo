---
name: covid-19-pubseq-pangenome-generate
description: This CWL workflow processes SARS-CoV-2 sequence data to construct, visualize, and index pangenome graphs using tools for read overlapping, graph induction, and odgi-based analysis. Use this skill when characterizing the evolutionary landscape of viral variants or identifying conserved and divergent genomic regions within large-scale COVID-19 sequence datasets.
homepage: http://covid-19.genenetwork.org/
metadata:
  docker_image: "N/A"
---

# covid-19-pubseq-pangenome-generate

## Overview

This [Common Workflow Language (CWL)](https://workflowhub.eu/workflows/63) workflow automates the construction and analysis of a pangenome graph from COVID-19 sequence data. It is designed to transform raw or pre-processed sequences into a structured variation graph, facilitating the study of genomic diversity across SARS-CoV-2 strains.

The pipeline begins with sequence preprocessing, including relabeling and deduplication, followed by read overlapping to induce and build the core pangenome graph. Once the graph is constructed, the workflow generates several analytical outputs, including graph visualizations and RDF-formatted data for semantic web integration.

To support downstream analysis, the workflow also performs path binning, merges relevant metadata, and generates a path index. These steps ensure the resulting pangenome is indexed for efficient querying and ready for comparative genomic studies.

## Inputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| inputReads |  | File[] |  |
| metadata |  | File[] |  |
| metadataSchema |  | File |  |
| subjects |  | string[] |  |
| exclude |  | File? |  |
| bin_widths |  | int[] | width of each bin in basepairs along the graph vector |
| cells_per_file |  | int | Cells per file on component_segmentation |


## Steps

| Step ID | Name | Description |
| --- | --- | --- |
| relabel | relabel |  |
| dedup | dedup |  |
| overlapReads | overlapReads |  |
| induceGraph | induceGraph |  |
| buildGraph | buildGraph |  |
| vizGraph | vizGraph |  |
| odgi2rdf | odgi2rdf |  |
| mergeMetadata | mergeMetadata |  |
| bin_paths | bin_paths |  |
| index_paths | Create path index |  |
| segment_components | Run component segmentation |  |

## Outputs

| ID | Name | Type | Description |
| --- | --- | --- | --- |
| odgiGraph |  | File |  |
| odgiPNG |  | File |  |
| seqwishGFA |  | File |  |
| odgiRDF |  | File |  |
| readsMergeDedup |  | File |  |
| mergedMetadata |  | File |  |
| indexed_paths |  | File |  |
| colinear_components |  | Directory |  |


## Files

- WorkflowHub: https://workflowhub.eu/workflows/63
- `pangenome-generate.cwl` — workflow definition (CWL)
- `report.md` — download metadata (`cwlagent download-workflow`)
- `ro-crate-metadata.json` — RO-Crate metadata