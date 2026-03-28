---
name: augur
description: Augur is a modular bioinformatics toolkit designed for analyzing pathogen evolution and building comprehensive phylogenetic models. Use when user asks to curate and filter sequence data, align sequences, infer and refine phylogenetic trees, reconstruct ancestral states, or export results for visualization in Auspice.
homepage: https://github.com/nextstrain/augur
---


# augur

## Overview

Augur is a modular bioinformatics toolkit designed for the analysis of pathogen evolution. It operates as a series of composable subcommands that transform raw sequence data and metadata into a comprehensive phylogenetic model. This skill provides guidance on using the Augur CLI to execute the "canonical" Nextstrain pipeline: from data curation and filtering to tree inference and final export for visualization in Auspice.

## Core Workflow & Subcommands

### 1. Data Curation and Filtering
Before analysis, data must be cleaned and subsampled to manage computational load and sampling bias.

- **`augur curate`**: A suite of tools to normalize metadata.
  - `augur curate normalize-strings`: Fixes encoding and capitalization.
  - `augur curate format-dates`: Standardizes various date formats into ISO 8601.
  - `augur curate parse-genbank-location`: Extracts geographic information from GenBank records.
- **`augur filter`**: Selects a subset of sequences based on criteria.
  - Use `--min-length` to remove short/poor quality sequences.
  - Use `--exclude` with a text file of IDs to remove known outliers.
  - Use `--subsample-max-sequences` to limit the dataset size.

### 2. Sequence Alignment
- **`augur align`**: Aligns nucleotide sequences using MAFFT.
  - **Best Practice**: Always provide a `--reference-sequence` to ensure all alignments are relative to a consistent coordinate system.
  - Use `--fill-gaps` if you want to treat gaps as missing data (N) rather than true indels.
  - *Note*: Amino acid alignment is not supported directly; align nucleotides first, then translate.

### 3. Phylogenetic Inference
- **`augur tree`**: Builds a maximum likelihood tree.
  - Supports `iqtree` (default), `raxml`, and `fasttree`.
  - **Expert Tip**: For very large datasets, `fasttree` is significantly faster but may be less accurate than `iqtree`.
- **`augur refine`**: Refines the tree to create a time-resolved phylogeny.
  - Requires metadata with dates.
  - It performs rerooting and estimates the molecular clock rate using TreeTime.

### 4. Ancestral Reconstruction & Translation
- **`augur ancestral`**: Infers nucleotide sequences at internal nodes of the tree.
- **`augur translate`**: Translates nucleotide sequences to amino acids based on a reference GFF/GTF annotation.
  - This identifies non-synonymous mutations across the tree.

### 5. Export for Visualization
- **`augur export v2`**: Consolidates the tree, metadata, and inferred traits into a single JSON file for Auspice.
  - Use `--auspice-config` to define map settings, colors, and filters for the web interface.
  - Use `--node-data` to include the outputs from `ancestral`, `translate`, and `traits`.

## Expert Tips

- **Composability**: Augur commands are designed to be piped or scripted. Each command typically takes an input from a previous step and produces a file (often JSON or FASTA) for the next.
- **Node Data**: Many commands (ancestral, translate, clades, traits) produce "node-data" JSON files. You can pass multiple node-data files to `augur export` to layer information onto the final tree.
- **Validation**: Run `augur validate` on your exported JSON files to ensure they are compatible with Auspice before deployment.
- **Reference Coordinates**: When masking sites (`augur mask`), ensure your coordinates match the reference used in `augur align`.



## Subcommands

| Command | Description |
|---------|-------------|
| augur align | Align multiple nucleotide sequences from FASTA. The "N" character is treated as missing or ambiguous sites, so aligning amino acid sequences is not supported. |
| augur ancestral | Infer ancestral sequences based on a tree. The ancestral sequences are inferred using TreeTime. Each internal node gets assigned a nucleotide sequence that maximizes a likelihood on the tree given its descendants and its parent node. Each node then gets assigned a list of nucleotide mutations for any position that has a mismatch between its own sequence and its parent's sequence. The node sequences and mutations are output to a node-data JSON file. If amino acid options are provided, the ancestral amino acid sequences for each requested gene are inferred with the same method as the nucleotide sequences described above. The inferred amino acid mutations will be included in the output node-data JSON file, with the format equivalent to the output of augur translate. The nucleotide and amino acid sequences are inferred separately in this command, which can potentially result in mismatches between the nucleotide and amino acid mutations. If you want amino acid mutations based on the inferred nucleotide sequences, please use augur translate. .. note:: The mutation positions in the node-data JSON are one-based. |
| augur curate | A suite of commands to help with data curation. |
| augur export | Export JSON files suitable for visualization with auspice. |
| augur filter | Filter and subsample a sequence set. SeqKit is used behind the scenes to handle FASTA files, but this should be considered an implementation detail that may change in the future. The CLI program seqkit must be available. If it's not on PATH (or you want to use a version different from what's on PATH), set the SEQKIT environment variable to path of the desired seqkit executable. VCFtools is used behind the scenes to handle VCF files, but this should be considered an implementation detail that may change in the future. The CLI program vcftools must be available on PATH. |
| augur frequencies | infer frequencies of mutations or clades |
| augur import | Import analyses into augur pipeline from other systems |
| augur index | Count occurrence of bases in a set of sequences. |
| augur merge | Merge two or more datasets into one. Datasets can consist of metadata and/or sequence files. If both are provided, the order and file contents are used independently. |
| augur reconstruct-sequences | Reconstruct alignments from mutations inferred on the tree |
| augur refine | Refine an initial tree using sequence metadata. |
| augur sequence-traits | Annotate sequences based on amino-acid or nucleotide signatures. |
| augur translate | Translate gene regions from nucleotides to amino acids. Translates nucleotide sequences of nodes in a tree to amino acids for gene regions of the annotated features of the provided reference sequence. Each node then gets assigned a list of amino acid mutations for any position that has a mismatch between its own amino acid sequence and its parent's sequence. The reference amino acid sequences, genome annotations, and node amino acid mutations are output to a node-data JSON file. .. note:: The mutation positions in the node-data JSON are one-based. |
| augur tree | Build a tree using a variety of methods. IQ-TREE specific: Strain names with spaces are modified to remove all characters after (and including) the first space. |
| augur write-file | Writes data to a file. |
| augur_distance | Calculate the distance between sequences across entire genes or at a predefined subset of sites. Distance calculations require selection of a comparison method (to determine which sequences to compare) and a distance map (to determine the weight of a mismatch between any two sequences). |
| augur_mask | Mask specified sites from a VCF or FASTA file. |
| augur_measurements | Create JSON files suitable for visualization within the measurements panel of Auspice. |
| augur_parse | Parse delimited fields from FASTA sequence names into a TSV and FASTA file. |
| augur_read-file | Read one or more files like Augur, with transparent optimized decompression and universal newlines. Supported compression formats: gzip (.gz), bzip2 (.bz2), xz (.xz), zstandard (.zst). Input is read from each given file path, as the compression format detection requires a seekable stream. A path may be "-" to explicitly read from stdin, but no decompression will be done. Output from each file is concatenated together and written to stdout. Universal newline translation is always performed, so \n, \r\n, and \r in the input are all translated to the system's native newlines (e.g. \n on Unix, \r\n on Windows) in the output. Additionally, each file is standardized to have trailing newlines. |
| augur_titers | Annotate a tree with actual and inferred titer measurements. |
| augur_traits | Infer ancestral traits based on a tree. |
| clades | Assign clades to nodes in a tree based on amino-acid or nucleotide signatures. Nodes which are members of a clade are stored via <OUTPUT_NODE_DATA> → nodes → <node_name> → clade_membership and if this file is used in `augur export v2` these will automatically become a coloring. The basal nodes of each clade are also given a branch label which is stored via <OUTPUT_NODE_DATA> → branches → <node_name> → labels → clade. The keys "clade_membership" and "clade" are customisable via command line arguments. |
| lbi | Calculate LBI for a given tree and one or more sets of parameters. |
| subsample | Subsample sequences from an input dataset. The input dataset can consist of a metadata file, a sequences file, or both. See documentation page for details on configuration. |

## Reference documentation

- [Augur CLI Reference](./references/docs_nextstrain_org_projects_augur_en_stable_usage_cli_cli.html.md)
- [Sequence Alignment (augur align)](./references/docs_nextstrain_org_projects_augur_en_stable_usage_cli_align.html.md)
- [Ancestral Reconstruction](./references/docs_nextstrain_org_projects_augur_en_stable_usage_cli_ancestral.html.md)
- [Data Filtering](./references/docs_nextstrain_org_projects_augur_en_stable_usage_cli_filter.html.md)
- [Metadata Curation](./references/docs_nextstrain_org_projects_augur_en_stable_usage_cli_curate_index.html.md)