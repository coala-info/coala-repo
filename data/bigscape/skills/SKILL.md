---
name: bigscape
description: BiG-SCAPE (Biosynthetic Gene Similarity Clustering and Prospecting Engine) is a specialized bioinformatics tool used to organize and visualize the diversity of secondary metabolite biosynthetic pathways.
homepage: https://github.com/medema-group/BiG-SCAPE
---

# bigscape

## Overview

BiG-SCAPE (Biosynthetic Gene Similarity Clustering and Prospecting Engine) is a specialized bioinformatics tool used to organize and visualize the diversity of secondary metabolite biosynthetic pathways. It transforms BGCs—typically predicted by antiSMASH—into a network of protein domains. By calculating pairwise distances based on domain content, order, and sequence identity, it clusters related BGCs into Gene Cluster Families (GCFs). Use this skill to navigate the four primary workflows of BiG-SCAPE 2: clustering, querying, dereplication, and benchmarking.

## Core Workflows

BiG-SCAPE 2 is invoked using `python bigscape.py [workflow] [options]`.

### 1. Cluster Mode
The primary workflow for generating similarity networks and GCFs.
- **Basic Command**: `python bigscape.py cluster --inputdir <path_to_gbks> --outputdir <results_path> --pfam_dir <pfam_db_path>`
- **Mixing Classes**: By default, BiG-SCAPE bins BGCs by antiSMASH class. Use `--mix` to group all BGCs into a single bin for a global network.
- **Cutoffs**: Define the stringency of clustering. You can provide multiple values to see how families split or merge: `--cutoffs 0.3 0.4 0.5`.

### 2. Query Mode
Search for BGCs similar to a specific sequence of interest.
- **Command**: `python bigscape.py query --query <query_bgc.gbk> --target <database_dir>`
- Useful for identifying homologs of a known pathway within a new set of genomes.

### 3. Dereplicate Mode
Identify and remove near-identical sequences to reduce computational load or redundancy in datasets.
- **Command**: `python bigscape.py dereplicate --inputdir <path>`
- This performs a protein sequence-based redundancy analysis.

### 4. Benchmark Mode
Validate clustering results against a "gold standard" set of BGC-to-GCF assignments.
- **Command**: `python bigscape.py benchmark --inputdir <results> --reference <assignments.csv>`

## Expert Tips and Best Practices

- **Pfam Database**: Ensure your Pfam database is properly pressed for HMMER (`hmmpress`). BiG-SCAPE relies on `hmmscan` to identify domains.
- **Input Validation**: BiG-SCAPE 2 is stricter with input validation than version 1. Ensure your GenBank files are properly formatted antiSMASH outputs.
- **Comparable Regions**: If your BGCs are on short contigs or are fragmented, pay attention to the alignment mode. BiG-SCAPE uses these to define the "comparable region" between two clusters.
- **Output Analysis**:
    - **HTML Visualization**: Open the `index.html` in the output directory for an interactive network view.
    - **SQLite Database**: For large-scale data mining, use the generated SQLite database which contains all pairwise distances and GCF assignments.
- **Performance**: For very large datasets, the `hmmscan` step is the bottleneck. BiG-SCAPE 2 includes optimizations, but ensure you allocate sufficient CPU cores using the `--cores` flag.

## Common CLI Patterns

**Run a standard analysis with MIBiG references:**
```bash
python bigscape.py cluster -i ./my_bgcs -o ./results --pfam_dir ./pfam --mibig
```

**Force a specific antiSMASH version compatibility:**
```bash
python bigscape.py cluster -i ./my_bgcs -o ./results --pfam_dir ./pfam --antismash_version 7
```

**Include specific reference BGCs from a local folder:**
```bash
python bigscape.py cluster -i ./my_bgcs -o ./results --pfam_dir ./pfam --extra_proximal_libs ./my_references
```

## Reference documentation
- [BiG-SCAPE Wiki](./references/github_com_medema-group_BiG-SCAPE_wiki.md)
- [BiG-SCAPE Main Repository](./references/github_com_medema-group_BiG-SCAPE.md)