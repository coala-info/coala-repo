---
name: dpcstruct
description: dpcstruct identifies protein domains through unsupervised clustering of 3D structural alignments. Use when user asks to identify structural domains, partition proteins into functional units, or perform large-scale structural clustering.
homepage: https://github.com/RitAreaSciencePark/DPCstruct
---


# dpcstruct

## Overview
dpcstruct is a specialized tool for structural bioinformatics that automates the identification of protein domains through unsupervised clustering. Unlike sequence-based methods, it leverages 3D structural similarity to partition proteins into functional units. It is particularly effective for large-scale structural datasets where manual domain annotation is impractical. The tool operates as a multi-stage pipeline that filters raw alignments, performs hierarchical clustering, and produces a clean mapping of protein indices to structural domain coordinates.

## Installation and Prerequisites
Ensure the following dependencies are available in your environment:
- **Foldseek**: Required for generating the initial all-vs-all structural alignments.
- **GNU Compiler**: Version 13.0 or higher.
- **Conda**: Available via `conda install bioconda::dpcstruct`.

## Core Pipeline Workflow
The `dpcstruct` command uses a modular architecture. Execute modules in the following sequence:

1.  **prefilters**: Clean raw Foldseek alignments.
2.  **primarycluster**: Group local alignments for each individual query sequence.
3.  **secondarycluster**: Perform higher-level clustering across the primary clusters.
4.  **traceback**: Map clusters back to the original protein sequences.
5.  **postfilters**: Final redundancy removal to produce the definitive domain set.

To view specific options for any module, use:
`dpcstruct <module> -h`

## Input Preparation (Foldseek)
dpcstruct requires specific alignment formats. Use the following pattern to generate compatible input from a directory of PDB files:

```bash
# 1. Index the PDBs
ls *.pdb | awk '{print NR,$1}' > protein_lookup.tsv

# 2. Create Foldseek database
foldseek createdb /path/to/pdbs/ pdbs_db

# 3. Run all-vs-all search
foldseek search pdbs_db pdbs_db alns tmp -a

# 4. Convert to dpcstruct-compatible format (Format Mode 4)
foldseek convertalis pdbs_db pdbs_db alns alns.tsv --format-mode 4 --format-output query,target,qstart,qend,tstart,tend,qlen,tlen,alnlen,pident,evalue,bits,alntmscore,lddt
```

## Working with AlphaFold Data
If using AlphaFold2 predictions, incorporate pLDDT scores to improve domain boundary accuracy. Use the provided utility script to fetch these values:
```bash
# Download and convert pLDDT values to compatible binary format
./util/download_plddts.sh <protein_list> <output_dir>
```

## Output Interpretation
The final output is a TSV file containing:
- `protIndex`: The unique identifier for the protein.
- `dom-start` / `dom-end`: The residue range defining the identified domain.
- `metaclusterID`: The structural category assigned to this domain.

## Best Practices
- **E-value Tuning**: When running `foldseek search`, adjust the e-value threshold based on the desired structural stringency.
- **Resource Management**: Use the `-j` flag during `make` (e.g., `make -j 4`) to speed up compilation, and ensure `SLURM_CPUS_PER_TASK` or equivalent environment variables are set for high-thread execution during the search phase.
- **Format Mode 4**: Always verify that `foldseek convertalis` uses `--format-mode 4`. dpcstruct will fail to parse standard BLAST-like or tabular outputs that lack the specific structural columns (TM-score, LDDT).

## Reference documentation
- [DPCstruct GitHub Repository](./references/github_com_RitAreaSciencePark_DPCstruct.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_dpcstruct_overview.md)