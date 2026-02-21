---
name: ac-diamond
description: The provided text does not contain help information for ac-diamond; it is a log of a failed container image build due to insufficient disk space.
homepage: https://github.com/Maihj/AC-DIAMOND
---

# ac-diamond

## Overview
AC-DIAMOND is a highly optimized DNA-protein alignment tool based on DIAMOND v0.7.9. It utilizes advanced SIMD parallelization and compressed indexing to achieve speeds approximately 6-7 times faster than the original DIAMOND while maintaining similar sensitivity levels. This skill provides the necessary command-line patterns to build reference databases, execute alignments across different sensitivity modes, and format output results.

## Core Workflow

### 1. Database Construction (makedb)
Before alignment, you must convert a FASTA protein reference into the AC-DIAMOND binary format.

```bash
# Basic database creation
ac-diamond makedb --in reference.fa -d ref_db

# Create a database optimized for sensitive modes
ac-diamond makedb --in reference.fa -d ref_db_sensitive --sensitive -b 4
```

*   **--block-size (-b)**: Sequence letters in billions per block. Adjust based on available RAM (default is 4).

### 2. Sequence Alignment (align)
Align DNA queries (FASTA/FASTQ) against the protein database.

```bash
# Fast mode alignment
ac-diamond align -d ref_db -q query.fa -a matches -t /tmp/directory

# Sensitive mode alignment
ac-diamond align -d ref_db_sensitive -q query.fa -a matches --sensitive -e 0.001 -z 6
```

*   **-a**: Output prefix (the tool appends `.daa`).
*   **-t**: Path to temporary directory. Using `/dev/shm` (RAM disk) is recommended for maximum speed.
*   **-z**: Query block size in billions of letters.

### 3. Result Visualization (view)
Convert the proprietary DAA output into human-readable or standard formats.

```bash
# Convert to BLAST tabular format
ac-diamond view -a matches.daa -o matches.m8 -f tab

# Convert to SAM format
ac-diamond view -a matches.daa -o matches.sam -f sam
```

## Sensitivity Modes

| Mode | Command Flag | Use Case |
| :--- | :--- | :--- |
| **Fast** | (Default) | High-speed screening of high-identity matches. |
| **Sensitive-2** | `--sensitive` | Deep searches for distant homologs; requires index built with `--sensitive`. |
| **Sensitive-1** | `sensitive1_search.sh` | A pipeline approach that runs Fast mode first, then re-runs unaligned queries in Sensitive-2 mode. |

## Performance Optimization Tips

*   **Thread Management**: Use `-p` or `--threads` to specify CPU cores. By default, it uses all available cores.
*   **Memory Tuning**: If the system runs out of memory, decrease the `--block-size` during `makedb` or `--query-block-size` during `align`.
*   **I/O Bottlenecks**: Always specify a fast local disk or RAM disk for the temporary directory (`-t`) to prevent network filesystem latency from slowing down the SIMD-accelerated compute.
*   **Scoring Parameters**: Fine-tune alignments using `--gapopen`, `--gapextend`, and `--matrix` (default is BLOSUM62).

## Reference documentation
- [AC-DIAMOND GitHub Repository](./references/github_com_Maihj_AC-DIAMOND.md)
- [Bioconda ac-diamond Package](./references/anaconda_org_channels_bioconda_packages_ac-diamond_overview.md)