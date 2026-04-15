---
name: asgal
description: ASGAL aligns RNA-Seq reads to a splicing graph to identify novel and known alternative splicing events. Use when user asks to map reads against a splicing graph, detect alternative splicing events such as exon skipping or intron retention, and perform genome-wide splicing analysis.
homepage: https://asgal.algolab.eu/
metadata:
  docker_image: "quay.io/biocontainers/asgal:1.1.8--h5ca1c30_2"
---

# asgal

## Overview
ASGAL (Alternative Splicing Graph ALigner) is a specialized bioinformatics tool that maps RNA-Seq reads directly against a splicing graph rather than a linear reference genome. This approach allows for more accurate detection of alternative splicing events, particularly novel ones not present in existing annotations. It is most effective when you have specific genes of interest or when performing genome-wide discovery of exon skipping, alternative donor/acceptor sites, and intron retention.

## Core Workflows

### Single Gene Analysis
To run the full pipeline (alignment, SAM conversion, and event detection) for a specific gene:
```bash
./asgal -g genome.fa -a annotation.gtf -s sample.fastq -o output_folder
```
*Note: For paired-end data in single-gene mode, you must merge the forward and reverse FASTQ files into one file first.*

### Genome-Wide Analysis
Use the `--multi` flag to process entire genomes. This mode uses Salmon for quasi-mapping to efficiently distribute reads to specific gene models before running the aligner.
```bash
./asgal --multi -g genome.fa -a annotation.gtf -s R1.fq -s2 R2.fq -t transcripts.fa -o output_folder
```

### Manual Step Execution
If you need to re-run specific parts of the pipeline:
1. **Align to Graph**: `./bin/SpliceAwareAligner -g genome.fa -a annotation.gtf -s sample.fq -o output.mem`
2. **Generate SAM**: `python3 scripts/formatSAM.py -m output.mem -g genome.fa -a annotation.gtf -o output.sam`
3. **Detect Events**: `python3 scripts/detectEvents.py -g genome.fa -a annotation.gtf -m output.mem -o output.csv`

## Parameter Tuning
- **Sensitivity (-l)**: The `-l` parameter sets the minimum MEM (Maximal Exact Match) length. Default is 15. Increase this to speed up processing; decrease it to improve sensitivity for short exons or high-error reads.
- **Error Rate (-e)**: The `-e` parameter (0-100) defines the allowed error rate. Default is 3. Ensure this matches across all manual steps if running scripts individually.
- **Support Threshold (-w)**: Use `-w` to set the minimum number of reads required to report an event. Default is 3.
- **Discovery Mode**: By default, ASGAL only outputs **novel** events. Use `--allevents` to include events already present in the GTF.

## Output Interpretation
The `.events.csv` file uses the following event codes:
- **ES**: Exon Skipping
- **A3**: Alternative Acceptor (3') site
- **A5**: Alternative Donor (5') site
- **IR**: Intron Retention

## Reference documentation
- [ASGAL Documentation](./references/asgal_algolab_eu_documentation.md)
- [Genome-Wide Analysis Guide](./references/asgal_algolab_eu_genomewide.md)
- [ASGAL Overview](./references/asgal_algolab_eu_index.md)