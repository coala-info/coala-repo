---
name: dazz_db
description: The Dazzler Data Base (DAZZ_DB) is a specialized storage system designed to facilitate the multiple phases of the Dazzler assembler.
homepage: https://github.com/thegenemyers/DAZZ_DB
---

# dazz_db

## Overview
The Dazzler Data Base (DAZZ_DB) is a specialized storage system designed to facilitate the multiple phases of the Dazzler assembler. It organizes PacBio read data and reference genomes into a compressed, indexed format that allows for incremental updates and random access. A key feature is the "track" system, which allows users to add arbitrary metadata (like low-complexity intervals or repeat masks) to reads without altering the core sequence data. It also supports partitioning large datasets into balanced blocks to enable parallel processing on compute clusters.

## Core Database Types
- **Sequence-DB (S-DB)**: Contains only DNA sequences.
- **Quiver-DB (Q-DB)**: Contains sequences plus PacBio Quiver quality value streams.
- **Arrow-DB (A-DB)**: Contains sequences plus Arrow pulse width streams.
- **Dazzler Map DB (DAM)**: A specialized DB for reference genomes where scaffolds are broken into contigs and original headers are preserved in a `.hdr` file.

## Common CLI Patterns

### Database Creation and Conversion
- **Create a DB from FASTA**: `fasta2DB <db_name> <input.fasta> ...`
- **Create a DAM from reference FASTA**: `fasta2DAM <dam_name> <reference.fasta> ...`
- **Export DB to FASTA**: `DB2fasta <db_name>`
- **Export DAM to FASTA**: `DAM2fasta <dam_name>`
- **Convert to 1-code format**: `DB2ONE <db_name>` (replaces the older `DBdump` utility).

### Partitioning and Parallelization
The `DBsplit` command is critical for cluster operations. It divides the database into blocks of roughly equal size based on total base pairs.
- **Split into 200MB blocks**: `DBsplit -s200 <db_name>`
- **Filter by read length**: `DBsplit -x1000 <db_name>` (ignores reads shorter than 1000bp).

### Metadata and Tracks
Tracks consist of `.anno` and `.data` files.
- **Mask low-complexity regions**: `DBdust <db_name>` (creates a `.dust` track).
- **Manage tracks**: Use `Catrack` to combine or manipulate track data.

### Maintenance and Inspection
- **Show statistics**: `DBstats <db_name>`
- **Display reads**: `DBshow <db_name> <read_id_range>`
- **Safe file operations**: Always use the tool-specific commands to ensure hidden secondary files are moved or removed correctly:
  - `DBmv <old_name> <new_name>`
  - `DBrm <db_name>`
  - `DBcp <source> <target>`

## Expert Tips
- **Hidden Files**: By default, DAZZ_DB stores data in "invisible" files (e.g., `.FOO.idx`, `.FOO.bps`). Do not manually move these files using standard UNIX `mv` or `rm` commands; use `DBmv` and `DBrm` to ensure the entire database bundle remains intact.
- **Incremental Loading**: You can add new sequence data to an existing database over time by running `fasta2DB` on the same database name with new input files.
- **Block Validity**: Avoid changing the partition parameters (`DBsplit`) in the middle of an assembly, as this will invalidate any interim results that rely on specific block indices.
- **DAM vs DB**: Use `.dam` for reference genomes. It automatically breaks scaffolds at runs of 'N's and tracks the original scaffold coordinates, which is essential for mapping reads back to a reference.

## Reference documentation
- [The Dazzler Database Library](./references/github_com_thegenemyers_DAZZ_DB.md)