---
name: proovframe
description: proovframe is a specialized tool designed to detect and correct frameshift errors in long-read (meta)genomic data.
homepage: https://github.com/thackl/proovframe
---

# proovframe

## Overview
proovframe is a specialized tool designed to detect and correct frameshift errors in long-read (meta)genomic data. Unlike consensus-based polishers that require high coverage, proovframe uses frameshift-aware protein alignments as guides to restore frame-fidelity. It achieves this by conservatively inserting or deleting "N" bases and masking premature stop codons. This makes it highly effective for environmental samples where specific taxa may lack the depth required for traditional polishing.

## Usage Workflow

The standard proovframe pipeline consists of two primary steps: mapping reference proteins to your reads and then applying the corrections.

### 1. Map Proteins to Reads
Use the `map` subcommand to generate the alignment information required for correction. This step requires DIAMOND (v2.0.3 or newer) to be installed in your path.

```bash
proovframe map -a reference_proteins.faa -o alignment_map.tsv target_sequences.fa
```

### 2. Fix Frameshifts
Use the `fix` subcommand to produce the corrected FASTA file based on the alignments generated in the previous step.

```bash
proovframe fix -o corrected_sequences.fa target_sequences.fa alignment_map.tsv
```

## Expert Tips and Best Practices

- **Guide Protein Selection**: proovframe is robust and can produce high-quality results even with distantly related guide proteins (tested successfully with <60% amino acid identity).
- **Metagenomic Polishing**: Use proovframe as an additional polishing step on top of classic consensus-polishing approaches for assemblies to catch remaining indels in coding regions.
- **Genetic Codes**: If working with non-standard organisms, ensure you specify the appropriate genetic code. The tool supports various NCBI genetic code tables (e.g., code 15).
- **Stop Codon Masking**: By default, the tool masks premature stops with "NNN". If your specific workflow requires keeping these or handling them differently, check the version-specific flags for `--no-stop-masking`.
- **Raw Read Processing**: Because it relies on protein guides rather than depth, you can run proovframe directly on raw reads that lack the coverage necessary for tools like Medaka or Pilon.

## Reference documentation
- [github_com_thackl_proovframe.md](./references/github_com_thackl_proovframe.md)
- [anaconda_org_channels_bioconda_packages_proovframe_overview.md](./references/anaconda_org_channels_bioconda_packages_proovframe_overview.md)
- [github_com_thackl_proovframe_commits_main.md](./references/github_com_thackl_proovframe_commits_main.md)