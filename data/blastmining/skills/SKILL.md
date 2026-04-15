---
name: blastmining
description: The blastmining tool automates the extraction of taxonomic information from BLAST results using consensus algorithms like majority voting or Lowest Common Ancestor. Use when user asks to assign taxonomy to sequences, perform majority voting on BLAST hits, find the lowest common ancestor for alignments, or run a full pipeline from FASTA input to taxonomic tables.
homepage: https://github.com/NuruddinKhoiry/blastMining
metadata:
  docker_image: "quay.io/biocontainers/blastmining:1.2.0--pyhdfd78af_0"
---

# blastmining

## Overview
The `blastmining` tool automates the extraction of taxonomic information from BLAST results. It bridges the gap between raw alignment data and biological interpretation by applying specific consensus algorithms to determine the most likely taxonomic origin of a sequence. Use this skill when you need to move beyond simple top-hit analysis and require more robust assignments through voting or LCA methods, or when you want to run a streamlined pipeline from FASTA input to taxonomic table.

## Core Requirements
Before running any mining command, ensure your BLAST output is in the specific format required by the tool.

**Required BLAST Format (outfmt 6):**
```bash
blastn -query input.fasta -db nt -outfmt "6 qseqid sseqid pident length mismatch gapopen evalue bitscore staxid" -out BLASTn.out
```
*Note: The tool is strictly dependent on these exact columns in this order.*

## Common CLI Patterns

### Method A: Majority Vote with Identity Cut-offs
Use this when you want to apply different stringency levels for different taxonomic ranks (e.g., 99% for species, 97% for genus).
```bash
blastMining vote -i BLASTn.out -o output_dir -txl 99,97,95,90,85,80,75 -n 10 -p project_prefix
```
*   `-txl`: Comma-separated identity thresholds for Kingdom through Species.
*   `-n`: Number of top hits to consider for the vote.

### Method B: Species-Level Voting
Use this for a simplified majority vote focused specifically on species-level assignments.
```bash
blastMining voteSpecies -i BLASTn.out -o output_dir -pi 99 -n 10
```

### Method C: Lowest Common Ancestor (LCA)
Use this for a more conservative assignment, finding the most specific common node among top hits.
```bash
blastMining lca -i BLASTn.out -o output_dir -pi 95 -n 10
```

### Method D: Best Hit
Use this for a standard top-hit assignment based on the highest bitscore/lowest e-value.
```bash
blastMining besthit -i BLASTn.out -o output_dir -pi 97
```

## Full Pipeline Execution
You can skip the manual BLAST step by using the `full_pipeline` command, which handles both the alignment and the mining.

```bash
blastMining full_pipeline \
  -i input.fasta \
  -o pipeline_out \
  -m vote \
  -bp "-db nt -max_target_seqs 10 -num_threads 8" \
  -txl 99,97,95,90,85,80,75
```
*   `-m`: Choose the mining method (`vote`, `voteSpecies`, `lca`, or `besthit`).
*   `-bp`: Pass standard BLAST+ parameters as a quoted string.

## Expert Tips & Best Practices
1.  **Database Setup**: Ensure `TaxonKit` is properly configured with the NCBI taxonomy database (`taxdump.tar.gz`), as `blastmining` relies on it for all taxonomic lookups.
2.  **Krona Visualization**: Add the `-kp` flag to any command to automatically generate a Krona plot for interactive hierarchical visualization of your results.
3.  **Parallel Processing**: Use the `-j` flag to specify the number of parallel jobs. This is particularly effective when processing large BLAST files with many sequences.
4.  **Cleanup**: Use the `-rm` flag to automatically delete the temporary directory (`TMPDIR`) after the run finishes to save disk space.
5.  **E-value Filtering**: Always set a meaningful e-value threshold with `-e` (default is 1e-3) to ignore statistically insignificant alignments before voting begins.

## Reference documentation
- [blastMining GitHub Repository](./references/github_com_NuruddinKhoiry_blastMining.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_blastmining_overview.md)