---
name: autocycler
description: Autocycler is a bioinformatics tool that generates high-quality consensus bacterial genome assemblies by combining multiple independent input assemblies. Use when user asks to produce a complete circularized genome, resolve assembly overlaps, cluster contigs from different assemblies, or manually clean assembly graphs to remove low-depth sequences.
homepage: https://github.com/rrwick/Autocycler
metadata:
  docker_image: "quay.io/biocontainers/autocycler:0.5.2--h3ab6199_0"
---

# autocycler

## Overview

Autocycler is a bioinformatics tool designed to produce complete, high-quality bacterial genome assemblies by combining multiple independent input assemblies. It addresses common assembly errors like failed circularization, spurious contigs, and fragmentation by using a De Bruijn graph approach to find consensus. Unlike its predecessor Trycycler, Autocycler is built for full automation but retains the ability for manual curation when dealing with complex linear sequences or plasmids.

## Core Workflow

The standard Autocycler pipeline follows a sequential command structure. Ensure all input assemblies are stored in a single directory before starting.

1. **Compress**: Consolidate all input assemblies into a single directory and generate the initial graph.
   ```bash
   autocycler compress -i input_assemblies_dir -a autocycler_out
   ```

2. **Cluster**: Group contigs that represent the same genomic sequence and perform Quality Control.
   ```bash
   autocycler cluster -a autocycler_out
   ```
   *Note: If the mean number of contigs per assembly exceeds 25, the tool will fail by default to prevent processing fragmented/contaminated data. Use `--max_contigs` to override if necessary.*

3. **Resolve**: Resolve overlaps and ambiguities within the clusters.
   ```bash
   autocycler resolve -a autocycler_out
   ```

4. **Combine**: Generate the final consensus assembly GFA.
   ```bash
   autocycler combine -a autocycler_out
   ```

## Manual Curation with `autocycler clean`

If the consensus assembly is not fully resolved (e.g., contains orange sequences in Bandage instead of blue "consentigs"), use the `clean` command to manually intervene.

### Common Patterns
* **Remove low-depth tigs**: Delete sequences supported by only a few input assemblies to allow higher-depth paths to merge.
  ```bash
  autocycler clean -i consensus.gfa -o cleaned.gfa -r 5,8
  ```
* **Automated depth filtering**: Quickly simplify messy graphs by removing all tigs below a specific depth.
  ```bash
  autocycler clean -i consensus.gfa -o cleaned.gfa -m 1
  ```
* **Handle Terminal Inverted Repeats (TIR)**: For linear plasmids with TIRs, run `clean` twice—first to remove low-depth sequences, then to duplicate the TIR tig.
  ```bash
  # Step 1: Remove noise
  autocycler clean -i consensus.gfa -o step1.gfa -r 4,6,7
  # Step 2: Duplicate the TIR (e.g., tig 4)
  autocycler clean -i step1.gfa -o final.gfa -d 4
  ```

## Expert Tips

* **Input Quality**: Autocycler requires that most input assemblies are "complete" (one contig per replicon). If your inputs are highly fragmented, Autocycler is likely inappropriate for the dataset.
* **Visual Verification**: Always load `consensus_assembly.gfa` into **Bandage** before and after cleaning. Use Bandage labels for "depth" to identify which sequences are well-supported by your input assemblies.
* **Contig Headers**: You can influence the clustering and QC process by adding hints to your input FASTA headers (e.g., `circular=true`).
* **Format Conversion**: If you need the final output in FASTA format instead of GFA, use the `gfa2fasta` utility:
  ```bash
  autocycler gfa2fasta -i cleaned_assembly.gfa -o final_assembly.fasta
  ```



## Subcommands

| Command | Description |
|---------|-------------|
| autocycler clean | manual manipulation of the final consensus assebly graph |
| autocycler cluster | cluster contigs in the unitig graph based on similarity |
| autocycler combine | combine Autocycler GFAs into one assembly |
| autocycler compress | compress input contigs into a unitig graph |
| autocycler decompress | decompress contigs from a unitig graph |
| autocycler dotplot | generate an all-vs-all dotplot from a unitig graph |
| autocycler gfa2fasta | convert an Autocycler GFA file to FASTA format |
| autocycler helper | helper commands for long-read assemblers |
| autocycler resolve | resolve repeats in the the unitig graph |
| autocycler subsample | subsample a long-read set |
| autocycler table | create TSV line from YAML files |
| autocycler trim | trim contigs in a cluster |

## Reference documentation
- [Home](./references/github_com_rrwick_Autocycler_wiki.md)
- [Autocycler clean](./references/github_com_rrwick_Autocycler_wiki_Autocycler-clean.md)
- [Autocycler cluster](./references/github_com_rrwick_Autocycler_wiki_Autocycler-cluster.md)
- [Autocycler combine](./references/github_com_rrwick_Autocycler_wiki_Autocycler-combine.md)
- [Autocycler compress](./references/github_com_rrwick_Autocycler_wiki_Autocycler-compress.md)