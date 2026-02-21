---
name: tinscan
description: The `tinscan` tool identifies transposon insertion sites by detecting specific alignment signatures where two contiguous segments in a query genome are separated by a gap in the target genome.
homepage: https://github.com/Adamtaranto/TE-insertion-scanner
---

# tinscan

## Overview
The `tinscan` tool identifies transposon insertion sites by detecting specific alignment signatures where two contiguous segments in a query genome are separated by a gap in the target genome. It automates the workflow from genome preparation and alignment (using LASTZ) to the final identification of insertion candidates and Target Site Duplications (TSDs). Use this skill when you need to perform comparative genomics to locate structural variations caused by mobile genetic elements.

## Core Workflow

### 1. Prepare Input Genomes
Before alignment, genomes must be split into individual scaffolds. Ensure sequence names are unique across both genomes.

```bash
tinscan-prep --adir data/A_target_split --bdir data/B_query_split \
             -A data/A_target_genome.fasta -B data/B_query_genome.fasta
```

### 2. Align Genomes
Align the split scaffolds. This step requires `LASTZ` to be installed in the environment.

```bash
tinscan-align --adir data/A_target_split --bdir data/B_query_split \
              --outdir A_Inserts --outfile A_Inserts_vs_B.tab \
              --minIdt 60 --minLen 100 --hspthresh 3000
```

*   **Expert Tip**: If you know homologous chromosome pairs, use the `--pairs` option with a tab-delimited file to significantly reduce computation time by avoiding all-vs-all comparisons.

### 3. Find Insertions
Scan the generated alignment table for insertion events and output results in GFF3 format.

```bash
tinscan-find --infile A_Inserts/A_Inserts_vs_B.tab \
             --outdir A_Inserts --gffOut A_Inserts_vs_B_results.gff3 \
             --maxInsert 50000 --minIdent 80 --maxIdentDiff 20
```

## Parameter Best Practices

| Parameter | Recommendation |
| :--- | :--- |
| `--minIdt` | Set to at least 60% during `tinscan-align` to capture divergent TE flanks. |
| `--minIdent` | Use a higher threshold (e.g., 80%) in `tinscan-find` to ensure high-confidence flanking alignments. |
| `--maxInsert` | Adjust based on the expected size of the TEs in your organism (default is often 50kb). |
| `--qGap` | Maximum allowable gap in the query genome B to consider segments contiguous (default is 0). |

## Algorithm Logic for Troubleshooting
If `tinscan` is not reporting expected insertions, verify that your data meets these internal criteria:
1.  Segments are contiguous in Query B (within `--qGap` distance).
2.  Segments are separated by an insertion in Target A within the `--minInsert` to `--maxInsert` range.
3.  At least one flanking alignment meets the `--minIdent` threshold.
4.  The identity difference between the two flanking mates is within `--maxIdentDiff`.

## Reference documentation
- [Tinscan GitHub Repository](./references/github_com_Adamtaranto_TE-insertion-scanner.md)
- [Tinscan Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_tinscan_overview.md)