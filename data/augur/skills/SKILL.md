---
name: augur
description: "Augur is a modular bioinformatics toolkit designed for real-time phylodynamic analysis and sequence curation. Use when user asks to curate genomic data, align sequences, infer phylogenetic trees, reconstruct ancestral states, or export data for Nextstrain visualizations."
homepage: https://github.com/nextstrain/augur
---


# augur

## Overview
Augur is a modular bioinformatics toolkit designed for real-time phylodynamic analysis. It serves as the computational engine for the Nextstrain platform, transforming raw genomic sequences and metadata into structured, interactive visualizations. Use this skill when you need to perform sequence curation, infer phylogenetic relationships, reconstruct ancestral states, or export data for pathogen surveillance.

## Core CLI Patterns

### Data Curation and Filtering
Use the `curate` and `filter` modules to prepare and subset your dataset.
- **Filtering by date**: `augur filter --sequences seqs.fasta --metadata meta.tsv --min-date 2023-01-01 --output filtered.fasta`
- **Strain name transformation**: `augur curate transform-strain-name --column strain --format lower`
- **Geolocation rules**: Use `augur curate apply-geolocation-rules` to standardize geographic metadata based on user-defined priority lists.

### Phylogenetic Workflow
The standard Augur workflow consists of composable commands that pass data through intermediate files:
1. **Align**: `augur align --sequences filtered.fasta --reference-sequence ref.gb --output aligned.fasta --fill-gaps`
2. **Tree**: `augur tree --alignment aligned.fasta --output raw_tree.nwk`
3. **Refine**: `augur refine --tree raw_tree.nwk --alignment aligned.fasta --metadata meta.tsv --output-tree time_tree.nwk --output-node-data branch_lengths.json --timetree`
4. **Ancestral**: `augur ancestral --tree time_tree.nwk --alignment aligned.fasta --output-node-data mutations.json --inference joint`

### Exporting for Visualization
The final step converts the tree and associated metadata into a JSON format compatible with Auspice.
- **Export v2**: `augur export v2 --tree time_tree.nwk --metadata meta.tsv --node-data branch_lengths.json mutations.json --output auspice_input.json`

## Best Practices and Expert Tips
- **Metadata Matching**: Ensure the "strain" or "name" column in your metadata TSV exactly matches the sequence headers in your FASTA file. Discrepancies will cause `augur filter` or `augur refine` to drop samples.
- **Layering Node Data**: `augur export v2` can accept an unlimited number of `--node-data` JSON files. Use this to layer different analyses (e.g., clades, traits, amino acid mutations) onto a single visualization.
- **Handling Missing Dates**: If your metadata contains incomplete dates (e.g., `2023-XX-XX`), `augur refine` can estimate the date, but ensure you use the `--timetree` flag and provide a valid rate of evolution or allow the tool to estimate it.
- **Translation Reconstruction**: When running `augur ancestral`, you can reconstruct amino acid changes by providing a reference GFF3 or GenBank file. Use `--genes` to limit reconstruction to specific proteins of interest to save computation time.
- **Validation**: Use `augur validate` (if available in your version) to check the integrity of your export JSONs before uploading them to Nextstrain.

## Reference documentation
- [Augur GitHub Repository](./references/github_com_nextstrain_augur.md)
- [Bioconda Augur Package Overview](./references/anaconda_org_channels_bioconda_packages_augur_overview.md)