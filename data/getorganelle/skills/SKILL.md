---
name: getorganelle
description: GetOrganelle is a specialized toolkit designed to extract and assemble organelle genomes from total genomic "skimming" data.
homepage: http://github.com/Kinggerm/GetOrganelle
---

# getorganelle

## Overview

GetOrganelle is a specialized toolkit designed to extract and assemble organelle genomes from total genomic "skimming" data. It utilizes a "seed-and-extend" strategy: it starts with a seed sequence (provided or default), recruits target reads through multiple rounds of extension, performs de novo assembly using SPAdes, and then slims and disentangles the resulting assembly graph to produce final organelle sequences. It is highly regarded for its ability to produce circularized plastomes and mitogenomes with minimal manual intervention.

## Configuration and Database Setup

Before running assemblies, you must initialize the local database for the specific organelle types you are targeting.

```bash
# Initialize for embryophyte chloroplast (plastome) and mitochondria
get_organelle_config.py --add embplant_pt,embplant_mt

# Other available types: embplant_nr, fungus_mt, fungus_nr, animal_mt, other_pt
```

## Primary Workflow: Assembly from Reads

The most common entry point is `get_organelle_from_reads.py`.

### Basic Command Pattern
```bash
get_organelle_from_reads.py -1 forward_reads.fq.gz -2 reverse_reads.fq.gz \
    -o output_directory \
    -F embplant_pt \
    -t 8 \
    -R 15
```

### Key Parameters
- `-1`, `-2`: Input paired-end reads (fastq or fastq.gz).
- `-o`: Output directory.
- `-F`: Target organelle type (e.g., `embplant_pt`, `animal_mt`, `fungus_mt`).
- `-R`: Maximum rounds of extension (default is 15; increase for low-coverage or difficult samples).
- `-k`: K-mer sizes for SPAdes (e.g., `-k 21,45,65,85,105`). A wide range helps resolve repeats.
- `-w`: Word size for seed searching. Usually auto-estimated, but can be manually set if auto-estimation fails.
- `-s`: Path to a custom seed (fasta). Using a related species' genome as a seed can significantly improve results for degraded or highly divergent samples.

## Expert Tips and Best Practices

### Input Data Quality
- **Trim Adapters**: Always use adapter-trimmed reads.
- **Quality Control**: While GetOrganelle is robust, extremely aggressive quality filtering can sometimes remove low-abundance organelle reads. Standard trimming is usually sufficient.
- **Data Volume**: For most angiosperms, 1-2 GB of data per end is sufficient for plastomes. Mitochondria may require 5 GB or more.

### Handling Assembly Failures
- **Non-Circular Results**: If the assembly does not circularize, try increasing the number of extension rounds (`-R`) or providing a more closely related seed sequence (`-s`).
- **Memory Issues**: If SPAdes runs out of memory, you can limit the number of reads used with `--max-reads` or `--reduce-reads-for-coverage`.
- **Animal Mitogenomes**: Auto-estimated word sizes (`-w`) can sometimes be inaccurate for animal data. If recruitment is low, try manually setting a smaller word size (e.g., `-w 15`).

### Post-Assembly Utilities
If you already have a completed assembly graph (GFA) and want to re-extract the organelle:
```bash
get_organelle_from_assembly.py -g assembly_graph.gfa -F embplant_pt -o output_dir
```

## Reference documentation
- [GetOrganelle Main Repository](./references/github_com_Kinggerm_GetOrganelle.md)
- [GetOrganelle Wiki and Usage Guide](./references/github_com_Kinggerm_GetOrganelle_wiki.md)