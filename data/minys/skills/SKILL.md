---
name: minys
description: MinYS extracts and assembles specific bacterial genomes from metagenomic datasets by using a reference genome as bait to recruit relevant reads. Use when user asks to assemble symbiont genomes from metagenomes, fill gaps in genomic assemblies, or convert GFA files to FASTA format.
homepage: https://github.com/cguyomar/MinYS
---

# minys

## Overview
MinYS (MineYourSymbiont) is a specialized bioinformatics pipeline designed to extract and assemble specific bacterial genomes from metagenomic datasets. Instead of performing a full de novo metagenomic assembly, it uses a reference genome as a "bait" to recruit relevant reads. The process involves mapping reads with BWA, performing a backbone assembly with Minia, filling gaps with MindTheGap, and finally simplifying the resulting assembly graph. It is particularly effective for recovering symbiont genomes where a related reference is available but the target organism has significant divergence or strain-specific variations.

## Core Workflow

### Basic Assembly
To run a standard assembly with paired-end reads and a reference genome:
```bash
MinYS.py -1 reads_1.fq -2 reads_2.fq -ref reference.fa -out results_dir
```

### Parameter Selection by Coverage
The quality of the assembly depends heavily on k-mer size and abundance thresholds.
- **Low Coverage (< 50x):** Use smaller k-mers (e.g., 25-31) and low abundance thresholds (e.g., 3).
- **High Coverage (> 100x):** Use larger k-mers (e.g., 51-61) and higher abundance thresholds (e.g., 10) to resolve repeats and filter sequencing errors.

Example for high-coverage symbionts:
```bash
MinYS.py -1 r1.fq -2 r2.fq -ref ref.fa \
    -assembly-kmer-size 61 -assembly-abundance-min 10 \
    -gapfilling-kmer-size 51 -gapfilling-abundance-min 5 \
    -nb-cores 8
```

### Bypassing Steps
If you already have contigs or a graph and want to resume or skip the initial mapping/assembly:
- **Use existing contigs:** `-contigs my_contigs.fa` (skips BWA and Minia).
- **Use existing graph:** `-graph my_graph.h5` (skips graph creation).

## Post-Processing and Utility Scripts
MinYS produces GFA (Graphical Fragment Assembly) files. The final output is typically found in `gapfilling/*.simplified.gfa`.

### Converting Graph to Fasta
To extract sequences from the simplified graph for downstream analysis:
```bash
python graph_simplification/gfa2fasta.py input.simplified.gfa output.fasta 0
```

### Filtering and Path Enumeration
- **Filter small components:** Remove disconnected nodes or small contigs that don't meet a size threshold (e.g., 100kb).
  ```bash
  python graph_simplification/filter_components.py input.gfa filtered.gfa 100000
  ```
- **Enumerate paths:** If the graph contains bubbles or multiple paths, use this to extract distinct genomic variants.
  ```bash
  python graph_simplification/enumerate_paths.py input.gfa output_dir
  ```

## Expert Tips
- **Reference Selection:** The reference does not need to be identical but should be close enough for BWA to recruit reads.
- **Visualization:** Use **Bandage** to visualize the `.gfa` files. This helps identify if the genome is circularized or if there are unresolved repeats.
- **Lustre Filesystems:** If running on a high-performance cluster using Lustre, set `export HDF5_USE_FILE_LOCKING='FALSE'` to avoid HDF5 errors during the MindTheGap step.
- **Masking:** Use the `-mask` option with a BED file to exclude highly conserved regions (like rRNA) that might recruit reads from non-target organisms in the metagenome.



## Subcommands

| Command | Description |
|---------|-------------|
| filter_components.py | Filters components based on minimum length. |
| minys_MinYS.py | MinYS: A pipeline for de novo assembly of circular DNA molecules |

## Reference documentation
- [MinYS README](./references/github_com_cguyomar_MinYS_blob_master_README.md)
- [MinYS Tutorial](./references/github_com_cguyomar_MinYS_blob_master_doc_tutorial.md)
- [MinYS CLI Source](./references/github_com_cguyomar_MinYS_blob_master_MinYS.py.md)