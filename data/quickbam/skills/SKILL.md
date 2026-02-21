---
name: quickbam
description: Quickbam is a high-performance utility designed for rapid access and manipulation of BAM (Binary Alignment Map) files.
homepage: https://gitlab.com/yiq/quickbam/-/tree/master/
---

# quickbam

## Overview
Quickbam is a high-performance utility designed for rapid access and manipulation of BAM (Binary Alignment Map) files. It leverages parallel processing to significantly speed up common bioinformatics tasks that are typically bottlenecked by single-threaded I/O. It is particularly effective for large-scale genomic datasets where standard tools like samtools might be too slow for specific extraction or summary statistics tasks.

## Command Line Usage

### Installation
Quickbam is primarily distributed via Bioconda.
```bash
conda install -c bioconda quickbam
```

### Common Patterns
The tool is designed to work with indexed BAM files. Ensure a `.bai` index exists for your input file.

**Calculating Coverage**
To calculate depth of coverage across a reference using parallel threads:
```bash
quickbam coverage input.bam > coverage.txt
```

**Region Extraction**
Extracting specific genomic coordinates efficiently:
```bash
quickbam view input.bam "chr1:1000000-2000000" > subset.bam
```

### Best Practices
- **Threading**: Quickbam automatically attempts to scale across available CPU cores. When running on HPC clusters, ensure you request the appropriate number of cores to match the tool's parallel execution.
- **Indexing**: Always index your BAM files (`samtools index sample.bam`) before using quickbam to ensure the parallel random access API can function correctly.
- **Piping**: Like many bioinformatics tools, quickbam supports standard streams. You can pipe the output directly into other analysis tools to save disk space and I/O overhead.

## Reference documentation
- [Quickbam Overview](./references/anaconda_org_channels_bioconda_packages_quickbam_overview.md)
- [Quickbam Source and Documentation](./references/gitlab_com_yiq_quickbam_-_tree_master.md)