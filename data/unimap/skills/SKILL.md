---
name: unimap
description: unimap aligns high-quality assemblies or long reads to a reference genome, specializing in large structural variations. Use when user asks to align assemblies or long reads to a reference, create a reference index, or generate alignment details for downstream analysis.
homepage: https://github.com/lh3/unimap
---


# unimap

## Overview

unimap is a specialized fork of minimap2 designed specifically for assembly-to-reference alignment. It excels at handling large structural variations and segmental duplications by integrating the minigraph chaining algorithm. While it is slower at indexing than its predecessor, it provides superior performance when aligning high-quality assemblies or long reads through significant insertions and deletions (up to 100kb). It is not intended for short-read mapping or multi-part index workflows.

## Installation

Install via Bioconda:
```bash
conda install bioconda::unimap
```

Or compile from source:
```bash
git clone https://github.com/lh3/unimap
cd unimap && make
```

## Common CLI Patterns

### Basic Alignment
Align an assembly to a reference and output in PAF format:
```bash
unimap -c reference.fa assembly.fa > output.paf
```

### Using Presets
Presets are the recommended way to configure unimap for specific data types:

*   **Assembly-to-reference (near identical):**
    ```bash
    unimap -cxasm5 --cs -t8 ref.fa asm.fa
    ```
*   **HiFi reads to reference:**
    ```bash
    unimap -cxhifi --cs -t8 ref.fa hifi-reads.fa
    ```
*   **Nanopore reads to reference:**
    ```bash
    unimap -cxont --cs -t8 ref.fa ont-reads.fa
    ```

### Indexing (Recommended)
unimap indexing is slower than minimap2. For repeated alignments against the same reference, pre-build and save the index:
```bash
# Create index
unimap -d reference.umi reference.fa

# Use index for alignment
unimap -c reference.umi assembly.fa > output.paf
```

## Expert Tips and Best Practices

*   **Memory Management:** If working with limited RAM, use the `-b` flag (e.g., `-b24`) to reduce memory usage during indexing and alignment.
*   **Long INDELs:** unimap is optimized for INDELs up to 100kb by default. If your assembly contains highly diverged regions, the `asm5` preset may represent them as a long insertion followed by a long deletion; this is expected behavior for this algorithm.
*   **Thread Scaling:** Use the `-t` flag to specify the number of CPU threads. unimap scales well with multi-threading during the mapping phase.
*   **CS Tag:** Always include `--cs` when you need the alignment details for downstream variant calling or visualization, as it generates the compact sequence string.
*   **Specialization:** Do not use unimap for short-read mapping or as a general-purpose replacement for minimap2; it is specifically tuned for high-quality assembly comparisons.

## Reference documentation

- [unimap - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_unimap_overview.md)
- [GitHub - lh3/unimap: A EXPERIMENTAL fork of minimap2 optimized for assembly-to-reference alignment](./references/github_com_lh3_unimap.md)