---
name: pbalign
description: pbalign serves as the standard wrapper for aligning PacBio reads.
homepage: https://github.com/PacificBiosciences/pbalign
---

# pbalign

## Overview
pbalign serves as the standard wrapper for aligning PacBio reads. It streamlines the alignment process by managing underlying mappers (like BLASR) and ensuring the output adheres to the PBBAM format specifications required by the SMRT Analysis software suite. It is the essential first step in workflows involving PacBio-specific tools like GenomicConsensus or Arrow.

## Common CLI Patterns

### Basic Alignment
Align subreads to a reference and produce a BAM file:
```bash
pbalign input.subreads.bam reference.fasta output.bam
```

### Using Dataset XMLs
PacBio workflows often use XML metadata files instead of raw BAMs:
```bash
pbalign input.subreadset.xml reference.referenceset.xml output.alignmentset.xml
```

### Filtering and Quality Control
Adjust alignment criteria to improve accuracy or throughput:
- `--minAccuracy`: Minimum percentage identity (e.g., 0.70).
- `--minLength`: Minimum aligned read length.
- `--hitPolicy`: Define how to handle multi-mapping reads (`random`, `all`, `allbest`, `leftmost`).

### Performance Tuning
- `--nproc`: Set the number of threads for parallel processing.
- `--concordant`: Use this flag when aligning LinkedReads or subreads from the same ZMW to ensure they are mapped to the same genomic location.

## Expert Tips
- **PBBAM Compliance**: Always ensure your output is a `.bam` or `.alignmentset.xml` if you plan to use PacBio's downstream consensus tools. pbalign automatically handles the metadata tagging required for these tools.
- **Algorithm Selection**: While pbalign defaults to optimized settings, you can pass specific parameters to the underlying mapper using `--mapperOptions`.
- **Memory Management**: For large genomes, ensure the reference index (SA index) is pre-generated or that sufficient memory is allocated for the indexing phase.

## Reference documentation
- [pbalign Overview](./references/anaconda_org_channels_bioconda_packages_pbalign_overview.md)