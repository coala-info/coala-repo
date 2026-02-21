---
name: ipcr
description: The `ipcr` suite provides high-performance tools for simulating polymerase chain reaction (PCR) experiments on digital genomic data.
homepage: https://github.com/KPU-AGC/ipcr
---

# ipcr

## Overview

The `ipcr` suite provides high-performance tools for simulating polymerase chain reaction (PCR) experiments on digital genomic data. It is particularly useful for bioinformaticians designing assays (like qPCR or TaqMan), validating primer pairs against large or circular genomes, and screening multiplex panels. The tool supports IUPAC ambiguity codes, handles gzipped FASTA inputs, and offers a "pretty" alignment mode to visualize how primers bind to the template.

## Core CLI Tools

The toolkit is divided into specialized binaries based on the assay type:

| Binary | Primary Use Case |
| :--- | :--- |
| `ipcr` | Standard PCR simulation with a single primer pair. |
| `ipcr-probe` | qPCR/TaqMan simulations requiring an internal probe. |
| `ipcr-nested` | Two-round assays (outer amplicon followed by inner scan). |
| `ipcr-multiplex` | Large-scale screening using TSV-based primer panels. |
| `ipcr-thermo` | Ranking and scoring products based on thermodynamic stability. |

## Common Usage Patterns

### Standard PCR Simulation
Use the base command for simple validation of a primer pair.
```bash
ipcr --forward AGAGTTTGATCMTGGCTCAG --reverse TACGGYTACCTTGTTAYGACTT \
  --circular \
  --pretty \
  genome.fna.gz
```

### Probe-Based (qPCR) Simulation
Use `-P` to specify the internal probe sequence.
```bash
ipcr-probe -f [FWD] -r [REV] -P [PROBE] --output json genome.fna
```

### Multiplex Panel Screening
For panels, provide a TSV file with the format: `id  FORWARD_PRIMER  REVERSE_PRIMER`.
```bash
ipcr-multiplex --primers panel.tsv --output jsonl --products genome.fna
```

### Nested PCR
Requires two sets of primers (outer and inner).
```bash
ipcr-nested --outer-primers outer.tsv --inner-primers inner.tsv genome.fna
```

## Expert Tips & Best Practices

- **IUPAC Awareness**: `ipcr` natively understands ambiguity codes (e.g., `M` for A/C, `Y` for C/T). However, it treats `N` in the genomic reference as a hard mismatch to prevent false positive hits in poorly sequenced regions.
- **Circular Templates**: Always use the `--circular` flag when working with bacterial plasmids or circular chromosomes to ensure amplicons spanning the origin are detected.
- **Mismatch Management**: Use `--mismatches N` to allow for non-perfect matches. Note that `ipcr` uses a 3′ terminal window model, as mismatches near the 3′ end of a primer are more likely to inhibit amplification in vitro.
- **Output Formats**: 
    - Use `--pretty` for human-readable ASCII alignments during discovery.
    - Use `--output json` or `jsonl` for downstream data processing.
    - Use `--sort` to ensure deterministic output order, which is critical for reproducible pipelines.
- **Performance**: The tool is written in Go and is highly parallel. Use `--threads N` to limit CPU usage in shared environments; otherwise, it defaults to all available cores.
- **Streaming**: You can pipe sequences directly into the tool using `-` as the input filename.

## Reference documentation
- [ipcr GitHub Repository](./references/github_com_KPU-AGC_ipcr.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_ipcr_overview.md)