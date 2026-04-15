---
name: rd-analyzer
description: RD-Analyzer detects Regions of Difference in Mycobacterium tuberculosis complex genomes to identify lineages and strains from raw sequence reads. Use when user asks to detect genomic deletions, identify MTBC strains, or analyze custom RD markers using sequence data.
homepage: https://github.com/xiaeryu/RD-Analyzer
metadata:
  docker_image: "quay.io/biocontainers/rd-analyzer:1.01--hdfd78af_0"
---

# rd-analyzer

## Overview

RD-Analyzer is a specialized bioinformatics tool for the *in silico* detection of Regions of Difference (RD) within the *Mycobacterium tuberculosis* complex (MTBC). By mapping raw sequence reads against specific RD markers, the tool predicts genomic deletions that serve as diagnostic signatures for different MTBC lineages and strains. It provides a streamlined workflow involving alignment (BWA-MEM) and depth/coverage calculation (SAMtools) to automate what would otherwise be a manual comparative genomics task.

## Tool Requirements

Before execution, ensure the following environment dependencies are met:
- **Python**: Version 2.7
- **BWA**: BWA-MEM must be installed and accessible in the system PATH.
- **SAMtools**: Version 0.1.19 is specifically required for compatibility.

## Standard RD Analysis

Use `RD-Analyzer.py` for standard strain identification based on the 30 previously defined RD markers.

### Basic Usage
```bash
python2.7 RD-Analyzer.py [options] FASTQ_1 FASTQ_2
```

### Common CLI Patterns
- **Standard Run**: `python2.7 RD-Analyzer.py -O ./output_dir -o sample_name reads_R1.fastq reads_R2.fastq`
- **Single-End Reads**: `python2.7 RD-Analyzer.py reads.fastq`
- **Personalized Thresholds**: Use `-p` to override optimized defaults.
  `python2.7 RD-Analyzer.py -p -m 0.1 -c 0.6 reads_R1.fastq reads_R2.fastq`

### Parameters
- `-O, --outdir`: Specify the directory for results (defaults to current directory).
- `-o, --output`: Set the basename for output files (e.g., `.sam`, `.bam`, `.result`).
- `-m, --min`: Read depth cut-off (0-1 scale, relative to average depth). Only used with `-p`.
- `-c, --coverage`: Sequence coverage cut-off (0-1 scale). Only used with `-p`.

## Extended RD Analysis

Use `RD-Analyzer-extended.py` to analyze user-specified sequences or potential markers not included in the standard set (e.g., Lineage 4 markers).

### Usage
```bash
python2.7 RD-Analyzer-extended.py [options] REF.FASTA FASTQ_1 FASTQ_2
```

### Reference FASTA Formatting
The extended version requires a specific header format in the `REF.FASTA` file to parse thresholds and descriptions. Headers must contain four fields separated by hyphens (`-`):
1. **Name**: Reference sequence name.
2. **Depth Cut-off**: Use `default` (0.09) or a float (0-1).
3. **Coverage Cut-off**: Use `default` (0.5) or a float (0-1).
4. **Description**: Information to display if the RD is detected.

**Example Header**: `>RD_Target_01-default-0.75-Custom_Lineage_Marker`

## Expert Tips and Best Practices

- **Stick to Defaults**: The default cut-offs (0.09 depth, 0.5 coverage) are optimized for MTBC analysis; only use the `-p` flag if you have specific evidence that your library prep or sequencing depth requires higher stringency.
- **Output Management**: The tool will refuse to overwrite existing files. Always specify a unique `-o` basename or a fresh `-O` directory for new samples.
- **Reference Files**: The standard markers are located in `Reference/RDs30.fasta`. If performing custom analysis, ensure your reference file does not contain spaces in the headers and uses hyphens only as field delimiters.
- **Debug Mode**: Use the `-d` flag to keep intermediate `.sam`, `.bam`, and `.depth` files if you need to manually inspect the alignments or verify the average depth calculations.



## Subcommands

| Command | Description |
|---------|-------------|
| RD-Analyzer-extended.py | RD-Analyzer-extended.py |
| RD-Analyzer.py | RD-Analyzer.py |

## Reference documentation
- [RD-Analyzer README](./references/github_com_xiaeryu_RD-Analyzer_blob_master_README.md)
- [Standard RD-Analyzer Script](./references/github_com_xiaeryu_RD-Analyzer_blob_master_RD-Analyzer.py.md)
- [Extended RD-Analyzer Script](./references/github_com_xiaeryu_RD-Analyzer_blob_master_RD-Analyzer-extended.py.md)