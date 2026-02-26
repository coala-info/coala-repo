# lassensus CWL Generation Report

## lassensus_reference-selection

### Tool Description
Selects the best reference genome from a directory of input FASTQ files based on various criteria.

### Metadata
- **Docker Image**: quay.io/biocontainers/lassensus:0.0.5--pyhdfd78af_0
- **Homepage**: https://github.com/DaanJansen94/lassensus
- **Package**: https://anaconda.org/channels/bioconda/packages/lassensus/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/lassensus/overview
- **Total Downloads**: 526
- **Last updated**: 2025-11-13
- **GitHub**: https://github.com/DaanJansen94/lassensus
- **Stars**: N/A
### Original Help Text
```text
usage: lassensus reference-selection [-h] -i INPUT_DIR -o OUTPUT_DIR
                                     [--min_identity MIN_IDENTITY]
                                     [--genome GENOME]
                                     [--completeness COMPLETENESS]
                                     [--host HOST] [--metadata METADATA]
                                     [--ref_reads REF_READS]

options:
  -h, --help            show this help message and exit
  -i INPUT_DIR, --input_dir INPUT_DIR
                        Directory containing input FASTQ files
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Directory for pipeline output
  --min_identity MIN_IDENTITY
                        Minimum identity threshold for reference selection
                        (default: 90.0)
  --genome GENOME       Genome completeness filter (1=Complete, 2=Partial,
                        3=None)
  --completeness COMPLETENESS
                        Minimum sequence completeness (1-100 percent)
  --host HOST           Host filter (1=Human, 2=Rodent, 3=Both, 4=None)
  --metadata METADATA   Metadata filter (1=Location, 2=Date, 3=Both, 4=None)
  --ref_reads REF_READS
                        Number of reads to rarefy for reference selection step
                        (default: 10,000). This is separate from --max_reads
                        used in consensus generation.
```


## lassensus_consensus

### Tool Description
Consensus calling pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/lassensus:0.0.5--pyhdfd78af_0
- **Homepage**: https://github.com/DaanJansen94/lassensus
- **Package**: https://anaconda.org/channels/bioconda/packages/lassensus/overview
- **Validation**: PASS

### Original Help Text
```text
usage: lassensus consensus [-h] -i INPUT_DIR -o OUTPUT_DIR
                           [--min_depth MIN_DEPTH] [--min_quality MIN_QUALITY]
                           [--majority_threshold MAJORITY_THRESHOLD]
                           [--max_reads MAX_READS]

options:
  -h, --help            show this help message and exit
  -i INPUT_DIR, --input_dir INPUT_DIR
                        Directory containing input FASTQ files
  -o OUTPUT_DIR, --output_dir OUTPUT_DIR
                        Directory for pipeline output
  --min_depth MIN_DEPTH
                        Minimum depth for consensus calling (default: 50)
  --min_quality MIN_QUALITY
                        Minimum quality score for consensus calling (default:
                        30)
  --majority_threshold MAJORITY_THRESHOLD
                        Majority rule threshold (default: 0.7)
  --max_reads MAX_READS
                        Maximum number of reads to use for consensus
                        generation (default: 1,000,000)
```

