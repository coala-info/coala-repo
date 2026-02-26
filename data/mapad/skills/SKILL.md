---
name: mapad
description: "mapAD is a damage-aware short-read mapper optimized for aligning ancient DNA sequences to a reference genome. Use when user asks to index a reference genome, map ancient DNA reads using a damage-aware model, or perform distributed mapping across a cluster."
homepage: https://github.com/mpieva/mapAD
---


# mapad

## Overview

mapAD is a specialized short-read mapper optimized for the unique characteristics of ancient DNA. It utilizes a damage-aware scoring model based on the ANFO/r-candy framework to handle the high rates of deamination (C to T and G to A transitions) typically found in degraded biological samples. By using a bidirectional FMD-index and a backtracking algorithm, it provides a fast and sensitive alternative to general-purpose mappers like BWA for paleogenomic data.

## Installation

The tool is available via Bioconda:

```bash
conda install bioconda::mapad
```

## Core Workflows

### 1. Indexing a Reference Genome
Before mapping, you must generate the FMD-index files. This process creates six auxiliary files (.tbw, .tle, .toc, .tpi, .trt, .tsa) in the same directory as the reference FASTA.

```bash
mapad index --reference /path/to/reference.fasta
```

### 2. Mapping Reads (Local Execution)
For standard local processing, use the `map` command. It is highly recommended to specify the library type and damage parameters to maximize sensitivity.

```bash
mapad -vv map \
  --threads 32 \
  --library single_stranded \
  -p 0.03 \
  -f 0.5 \
  -t 0.5 \
  -d 0.02 \
  -s 1.0 \
  -i 0.001 \
  --reads input.bam \
  --reference /path/to/reference.fasta \
  --output output.bam
```

### 3. Distributed Mapping
For large datasets, mapAD supports a dispatcher-worker architecture to spread the load across multiple nodes in a cluster.

**Start the Dispatcher:**
```bash
mapad -v map --dispatcher [parameters as above]
```

**Spawn Workers (on cluster nodes):**
```bash
mapad -vv worker --threads 8 --host <dispatcher_hostname>
```

## Parameter Guide & Best Practices

### Damage Model Parameters
*   **`-p` (Mismatch Rate):** Allowed mismatches under the base error rate. `0.03` is a standard starting point.
*   **`--library`:** Set to `single_stranded` or `double_stranded`. This dictates how deamination probabilities are applied to the read ends.
*   **`-f` and `-t`:** 5' and 3' overhang parameters. In single-stranded libraries, `-f` and `-t` are both used; in double-stranded, only `-f` is used as a generic overhang parameter.
*   **`-s` (Single-strand deamination):** Rate in overhangs (often set to `1.0` for high-damage samples).
*   **`-d` (Double-strand deamination):** Rate in double-stranded parts of the molecule.

### Expert Tips
*   **Verbosity:** Use `-vv` to get detailed progress updates during the mapping process.
*   **Damage Over-specification:** Over-specifying damage parameters (e.g., setting high deamination rates) generally does not significantly hurt alignment accuracy, making it safer to be aggressive with these settings.
*   **Mapping Quality (MAPQ):** mapAD MAPQ scores are similar to BWA, but with one key difference: if a read maps equally well to two positions, mapAD assigns a MAPQ of 3 (BWA assigns 0). Use a threshold of `> 5-10` for reliable filtering.
*   **Performance:** If compiling from source, use `RUSTFLAGS="-C target-feature=+avx2,+fma"` to enable SIMD instructions for significantly faster processing on modern CPUs.

## Reference documentation
- [mapAD GitHub Repository](./references/github_com_mpieva_mapAD.md)
- [mapAD Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_mapad_overview.md)