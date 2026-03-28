---
name: gs-tama
description: "gs-tama processes long-read transcriptomic mappings to produce refined, non-redundant transcript annotations. Use when user asks to collapse mapped reads into transcript models, merge multiple annotation files, or assign CDS and UTR regions to BED files."
homepage: https://github.com/sguizard/gs-tama
---

# gs-tama

## Overview

TAMA (Transcriptome Annotation by Modular Algorithms) is a specialized toolkit for handling the high error rates and structural complexities of long-read transcriptomics. It transforms raw genomic mappings (SAM files) into refined, non-redundant transcript annotations. The tool is particularly effective at "fuzzy" matching, allowing users to define thresholds for 5', 3', and splice junction variations to account for sequencing noise or biological wobble.

## Core Workflows

### Collapsing Transcripts with tama_collapse.py

Use this script to take a sorted SAM file of mapped reads and produce a non-redundant set of transcript models.

**Basic Command Pattern:**
```bash
python tama_collapse.py -s <input.sam> -f <genome.fasta> -p <output_prefix> -x <capped_mode>
```

**Key Parameters:**
- `-s`: Input SAM file. **Must be sorted by coordinate.**
- `-f`: Reference genome FASTA file.
- `-p`: Prefix for all output files (e.g., `.bed`, `.txt`).
- `-x`: Use `capped` if your library prep specifically captures 5' caps (e.g., TeloPrime); use `no_cap` for standard Iso-Seq or cDNA-Seq.
- `-a`, `-m`, `-z`: Thresholds (in bp) for 5' end, splice junctions, and 3' end respectively. Default is 10bp. Increase these if dealing with high-noise data.
- `-i`: Identity threshold (default 85).
- `-c`: Coverage threshold (default 99).

### Merging Annotations with tama_merge.py

Use this script to combine multiple TAMA BED files (from different samples or tissues) into a single unified transcriptome.

**Basic Command Pattern:**
```bash
python tama_merge.py -f <file_list.txt> -p <output_prefix>
```

**Note on File List:** The input file `-f` expects a text file where each line contains the path to a BED file, the merge priority (e.g., `capped` or `no_cap`), the cap status, and a sample name.

## Expert Tips and Best Practices

- **SAM Sorting:** TAMA requires coordinate-sorted SAM files. If your aligner (like Minimap2) outputs unsorted data, use `samtools sort` before running `tama_collapse.py`.
- **Splice Junction Priority:** If you have high-confidence splice junction information (e.g., from short-read data), use the `-sj sj_priority` flag to prioritize these junctions during the collapse process.
- **Identity Calculation:** By default, TAMA uses `ident_cov` which includes coverage in the identity calculation. If you want to exclude hard and soft clipping from the identity score, use `-icm ident_map`.
- **Output Interpretation:**
    - `.bed`: The final collapsed transcript models.
    - `_trans_report.txt`: Detailed information on how many reads were collapsed into each transcript.
    - `_polya.txt`: Information regarding poly-A tail detection if applicable.



## Subcommands

| Command | Description |
|---------|-------------|
| tama_cds_regions_bed_add.py | This script uses data from the blastp parse file and the original annotation to assign the locations of the UTR/CDS regions to the bed file |
| tama_collapse.py | This script collapses mapped transcript models |
| tama_filter_primary_transcripts_orf.py | This script uses the ORF/NMD output bed file and filters to have only 1 transcript per gene |
| tama_merge.py | This script merges transcriptomes. |
| tama_remove_fragment_models.py | This script absorbs transcriptomes. |
| tama_remove_single_read_models_levels.py | This script uses the TAMA collapse and TAMA merge outputs to remove single read models |

## Reference documentation

- [TAMA Collapse Script](./references/github_com_sguizard_gs-tama_blob_master_tama_collapse.py.md)
- [TAMA Merge Script](./references/github_com_sguizard_gs-tama_blob_master_tama_merge.py.md)
- [Project README](./references/github_com_sguizard_gs-tama_blob_master_README.md)