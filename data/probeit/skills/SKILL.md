---
name: probeit
description: Probeit automates the design of dual-probe sets for pathogen detection and genotyping. Use when user asks to design probes for specific genomic targets, identify sequences present in a positive genome but absent in a negative background, or target specific nucleotide and amino acid mutations.
homepage: https://github.com/steineggerlab/probeit
---

# probeit

## Overview
Probeit is a specialized bioinformatics tool designed to automate the creation of dual-probe sets. It generates "Probe1" (typically 40nt, ligation probe) and "Probe2" (typically 20nt, capture probe) to identify specific pathogens or strains. It is particularly useful for researchers working on diagnostic assays where high specificity is required to distinguish between closely related genomic sequences or to detect specific functional mutations.

## Workflow Selection

### 1. Pathogen Detection (posnegset)
Use this workflow to find sequences present in a target "positive" genome but absent in a "negative" background genome.

**Basic Command:**
```bash
probeit posnegset -p positive.fa -n negative.fa -o output_dir
```

**Key Parameters:**
- `-p/--positive`: The target genome(s) that probes must cover.
- `-n/--negative`: The background genome(s) that probes must avoid.
- `-o/--output`: The directory where results will be stored.

### 2. Pathogen Genotyping (snp)
Use this workflow to design probes targeting specific known mutations. It supports both nucleotide-level and amino-acid-level SNP specifications.

**Nucleotide SNP Command:**
```bash
probeit snp -r ref.fa -s strain.fa -p "10,20" -m "nt:A21716G,nt:G23011A" -o output_dir
```

**Amino Acid SNP Command:**
```bash
probeit snp -r ref.fa -s strain.fa -a ref.gff -p "10,20" -m "aa:S:Q52R,aa:E:L21F" -o output_dir
```

**Key Parameters:**
- `-r/--reference`: The wild-type or reference genome.
- `-s/--strain`: The genome containing the target SNPs.
- `-a/--annotation`: Required only for `aa` (amino acid) mutations to map protein changes to genomic coordinates.
- `-p/--positions`: Comma-separated integers defining the SNP position within the 1st probe.
- `-m/--mutations`: Comma-separated list of mutations (prefix with `nt:` for nucleotide or `aa:gene:mutation` for amino acid).

## Understanding Outputs
Probeit generates two primary FASTA files in the output directory:
- `sorted1.fa`: Contains **Probe1** sequences (ligation probes).
- `sorted2.fa`: Contains **Probe2** sequences (capture probes).

**Header Logic:**
- In `posnegset`, headers link Probe2 to the specific Probe1 IDs they cover.
- In `snp`, headers explicitly list the SNP and the relative position used during design.

## Expert Tips
- **Environment Setup**: Probeit relies on several heavy dependencies (mmseqs2, bedtools, primer3). Always ensure the `setcover` component is compiled via `bash install.sh` in the source directory before first use.
- **Probe Spacing**: By default, Probe2 is designed to be within 200nt of Probe1 without overlapping. If your assay requires tighter or broader spacing, check for additional optional flags in the CLI help.
- **SNP Positioning**: The `-p` parameter is critical for assay sensitivity. Placing the SNP at different offsets within the 40nt Probe1 can affect ligation efficiency; testing multiple positions (e.g., "10,11,12") is recommended.



## Subcommands

| Command | Description |
|---------|-------------|
| probeit | It generates a probe set with sequences included in the positive genome but not in the negative genome |
| probeit_snp | It generates a probe set which detect input amino acid SNPs from strain genome. |

## Reference documentation
- [Probeit GitHub README](./references/github_com_steineggerlab_probeit_blob_master_README.md)
- [Probeit Installation Guide](./references/github_com_steineggerlab_probeit_blob_master_install.sh.md)
- [Probeit Requirements](./references/github_com_steineggerlab_probeit_blob_master_requirements.md)