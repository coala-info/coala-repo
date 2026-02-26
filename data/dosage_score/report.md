# dosage_score CWL Generation Report

## dosage_score

### Tool Description
Dosage-score pipeline 2023/8/21

### Metadata
- **Docker Image**: quay.io/biocontainers/dosage_score:1.0.0--pyhdfd78af_0
- **Homepage**: https://github.com/SegawaTenta/Dosage-score
- **Package**: https://anaconda.org/channels/bioconda/packages/dosage_score/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dosage_score/overview
- **Total Downloads**: 1.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/SegawaTenta/Dosage-score
- **Stars**: N/A
### Original Help Text
```text
usage: dosage_score

Dosage-score pipeline 2023/8/21

options:
  -h, --help            show this help message and exit
  -r1 REF_FA1, --ref_fa1 REF_FA1
                        Referance fasta file.
  -r2 REF_FA2, --ref_fa2 REF_FA2
                        Masked referance fasta file.
  -l LINK_FILE, --link_file LINK_FILE
                        Link file compared between 2 genome fasta.
  -g GENOME_INFO, --genome_info GENOME_INFO
                        Genome info file.
  -b BAM_INFO, --bam_info BAM_INFO
                        BAM info file.
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Output directory. [dosage_score]
  -t THREAD, --thread THREAD
                        Thread. [1]
  -minMQ MINMQ, --minMQ MINMQ
                        Minimum mapping quality for an alignment to be used.
                        [60]
  -minBQ MINBQ, --minBQ MINBQ
                        Minimum base quality for a base to be considered. [13]
  -window_size WINDOW_SIZE, --window_size WINDOW_SIZE
                        Minumum plot in window size. [2000000]
  -step_size STEP_SIZE, --step_size STEP_SIZE
                        Minumum plot in window size. [500000]
```

