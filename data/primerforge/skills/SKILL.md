---
name: primerforge
description: primerforge identifies specific genomic primer pairs by analyzing ingroup targets and excluding outgroup sequences. Use when user asks to design primers for specific amplification, identify shared primers across multiple genomes, or filter primers based on melting temperature and PCR product size.
homepage: https://github.com/dr-joe-wirth/primerForge
metadata:
  docker_image: "quay.io/biocontainers/primerforge:1.5.3--pyhdfd78af_0"
---

# primerforge

## Overview
The `primerforge` skill enables the automated identification of genomic primers tailored for specificity. It works by analyzing "ingroup" genomes (targets for amplification) and optional "outgroup" genomes (targets to avoid). The tool filters candidate primers based on melting temperature (Tm), GC content, secondary structures (hairpins/dimers), and homopolymers. It then identifies primer pairs that produce PCR products within a specified size range for the ingroup while ensuring the outgroup does not produce similar products.

## Installation and Verification
Before running analysis, ensure the environment is correctly configured. Note that `primerforge` requires Python 3.9, 3.10, or 3.11.

```bash
# Verify installation
primerForge --check_install

# If installed manually via repository
python primerForge.py --check_install
```

## Common CLI Patterns

### Basic Specificity Analysis
To find primers shared across all ingroup genomes that are absent in the outgroup:
```bash
primerForge -i "ingroup/*.gbff" -u "outgroup/*.gbff" -o specific_primers.tsv
```

### Working with FASTA Files
The default format is GenBank. Use `-f fasta` for FASTA inputs:
```bash
primerForge -i targets.fasta -u decoys.fasta -f fasta -o results.tsv
```

### Customizing PCR Product Constraints
Adjust the expected size of the amplified fragment (default 120-2400bp):
```bash
primerForge -i ingroup.gbff -r 200,500 -o short_pcr_results.tsv
```

### High-Throughput Processing
Utilize multiple CPU cores to speed up k-mer counting and primer filtering:
```bash
primerForge -i "*.gbff" -n 8
```

## Expert Tips and Best Practices

### Optimizing Outgroup Exclusion
By default, the outgroup exclusion (`-b`) uses the same PCR product range as the ingroup (`-r`). If you want to be more stringent—for example, ensuring the outgroup doesn't produce *any* product between 50bp and 5000bp—set the range explicitly:
```bash
primerForge -i ingroup.gbff -u outgroup.gbff -r 150,300 -b 50,5000
```

### Primer Design Constraints
*   **Length**: Use `-p` to set a fixed length (e.g., `-p 20`) or a range (e.g., `-p 18,22`).
*   **Melting Temperature**: If your PCR protocol requires a specific Tm, adjust `-t` (e.g., `-t 60,65`).
*   **Tm Difference**: Keep the forward and reverse primers balanced by lowering `-d` (default is 5.0°C).

### Interpreting Results
The output `results.tsv` is ranked by quality. The most important ranking criteria are:
1.  Largest difference in PCR product size between ingroup and outgroup.
2.  Lowest number of outgroup PCR products.
3.  Minimal GC and Tm differences between the primer pair.

### Handling Overlapping Primers
`primerforge` bins overlapping primers to reduce redundancy. If you find the results are too sparse, you can adjust the `--bin_size` (default 64bp). A smaller bin size will result in more candidate pairs but higher redundancy.

## Reference documentation
- [github_com_dr-joe-wirth_primerForge.md](./references/github_com_dr-joe-wirth_primerForge.md)
- [anaconda_org_channels_bioconda_packages_primerforge_overview.md](./references/anaconda_org_channels_bioconda_packages_primerforge_overview.md)