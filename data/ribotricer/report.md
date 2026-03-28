# ribotricer CWL Generation Report

## ribotricer_count-orfs

### Tool Description
Count reads for detected ORFs at gene level

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotricer:1.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/smithlabcode/ribotricer
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotricer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ribotricer/overview
- **Total Downloads**: 31.0K
- **Last updated**: 2026-02-14
- **GitHub**: https://github.com/smithlabcode/ribotricer
- **Stars**: N/A
### Original Help Text
```text
Usage: ribotricer count-orfs [OPTIONS]

  Count reads for detected ORFs at gene level

Options:
  --ribotricer_index TEXT  Path to the index file of ribotricer This file
                           should be generated using ribotricer prepare-orfs
                           [required]
  --detected_orfs TEXT     Path to the detected orfs file This file should be
                           generated using ribotricer detect-orfs  [required]
  --features TEXT          ORF types separated with comma  [required]
  --out TEXT               Path to output file  [required]
  --report_all             Whether output all ORFs including those non-
                           translating ones
  -h, --help               Show this message and exit.
```


## ribotricer_count-orfs-codon

### Tool Description
Count reads for detected ORFs at codon level

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotricer:1.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/smithlabcode/ribotricer
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotricer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ribotricer count-orfs-codon [OPTIONS]

  Count reads for detected ORFs at codon level

Options:
  --ribotricer_index TEXT        Path to the index file of ribotricer This
                                 file should be generated using ribotricer
                                 prepare-orfs  [required]
  --detected_orfs TEXT           Path to the detected orfs file This file
                                 should be generated using ribotricer detect-
                                 orfs  [required]
  --features TEXT                ORF types separated with comma  [required]
  --ribotricer_index_fasta TEXT  Path to ORF seq file  [required]
  --prefix TEXT                  Prefix for output files  [required]
  --report_all                   Whether output all ORFs including those non-
                                 translating ones
  -h, --help                     Show this message and exit.
```


## ribotricer_detect-orfs

### Tool Description
Detect translating ORFs from BAM file

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotricer:1.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/smithlabcode/ribotricer
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotricer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ribotricer detect-orfs [OPTIONS]

  Detect translating ORFs from BAM file

Options:
  --bam TEXT                      Path to BAM file  [required]
  --ribotricer_index TEXT         Path to the index file of ribotricer This
                                  file should be generated using ribotricer
                                  prepare-orfs  [required]
  --prefix TEXT                   Prefix to output file  [required]
  --stranded [yes|no|reverse]     whether the data is from a strand-specific
                                  assay If not provided, the experimental
                                  protocol will be automatically inferred
  --read_lengths TEXT             Comma separated read lengths to be used,
                                  such as 28,29,30 If not provided, it will be
                                  automatically determined by assessing the
                                  metagene periodicity
  --psite_offsets TEXT            Comma separated P-site offsets for each read
                                  length matching the read lengths provided.
                                  If not provided, reads from different read
                                  lengths will be automatically aligned using
                                  cross-correlation
  --phase_score_cutoff FLOAT      Phase score cutoff for determining active
                                  translation  [default: 0.428571428571]
  --min_valid_codons INTEGER      Minimum number of codons with non-zero reads
                                  for determining active translation
                                  [default: 5]
  --min_reads_per_codon INTEGER   Minimum number of reads per codon for
                                  determining active translation  [default: 0]
  --min_valid_codons_ratio FLOAT  Minimum ratio of codons with non-zero reads
                                  to total codons for determining active
                                  translation  [default: 0]
  --min_read_density FLOAT        Minimum read density (total_reads/length)
                                  over an ORF total codons for determining
                                  active translation  [default: 0.0]
  --report_all                    Whether output all ORFs including those non-
                                  translating ones
  --meta-min-reads INTEGER        Minimum number of reads for a read length to
                                  be considered  [default: 100000]
  -h, --help                      Show this message and exit.
```


## ribotricer_learn-cutoff

### Tool Description
Learn phase score cutoff from BAM/TSV file

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotricer:1.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/smithlabcode/ribotricer
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotricer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ribotricer learn-cutoff [OPTIONS]

  Learn phase score cutoff from BAM/TSV file

Options:
  --ribo_bams TEXT                Path(s) to Ribo-seq BAM file separated by
                                  comma
  --rna_bams TEXT                 Path(s) to RNA-seq BAM file separated by
                                  comma
  --ribo_tsvs TEXT                Path(s) to Ribo-seq *_translating_ORFs.tsv
                                  file separated by comma
  --rna_tsvs TEXT                 Path(s) to RNA-seq *_translating_ORFs.tsv
                                  file separated by comma
  --ribotricer_index TEXT         Path to the index file of ribotricer This
                                  file should be generated using ribotricer
                                  prepare-orfs (required for BAM input)
  --prefix TEXT                   Prefix to output file
  --filter_by_tx_annotation TEXT  transcript_type to filter regions by
                                  [default: protein_coding]
  --phase_score_cutoff FLOAT      Phase score cutoff for determining active
                                  translation (required for BAM input)
                                  [default: 0.428571428571]
  --min_valid_codons INTEGER      Minimum number of codons with non-zero reads
                                  for determining active translation (required
                                  for BAM input)  [default: 5]
  --sampling_ratio FLOAT          Number of protein coding regions to sample
                                  per bootstrap  [default: 0.33]
  --n_bootstraps INTEGER          Number of bootstraps  [default: 20000]
  -h, --help                      Show this message and exit.
```


## ribotricer_orfs-seq

### Tool Description
Generate sequence for ORFs in ribotricer's index

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotricer:1.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/smithlabcode/ribotricer
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotricer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ribotricer orfs-seq [OPTIONS]

  Generate sequence for ORFs in ribotricer's index

Options:
  --ribotricer_index TEXT  Path to the index file of ribotricer This file
                           should be generated using ribotricer prepare-orfs
                           [required]
  --fasta TEXT             Path to FASTA file  [required]
  --protein                Output protein sequence instead of nucleotide
  --saveto TEXT            Path to output file  [required]
  -h, --help               Show this message and exit.
```


## ribotricer_prepare-orfs

### Tool Description
Extract candidate ORFS based on GTF and FASTA files

### Metadata
- **Docker Image**: quay.io/biocontainers/ribotricer:1.5.0--pyhdfd78af_0
- **Homepage**: https://github.com/smithlabcode/ribotricer
- **Package**: https://anaconda.org/channels/bioconda/packages/ribotricer/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ribotricer prepare-orfs [OPTIONS]

  Extract candidate ORFS based on GTF and FASTA files

Options:
  --gtf TEXT                Path to GTF file  [required]
  --fasta TEXT              Path to FASTA file  [required]
  --prefix TEXT             Prefix to output file  [required]
  --min_orf_length INTEGER  The minimum length (nts) of ORF to include
                            [default: 60]
  --start_codons TEXT       Comma separated list of start codons  [default:
                            ATG]
  --stop_codons TEXT        Comma separated list of stop codons  [default:
                            TAG,TAA,TGA]
  --longest                 Choose the most upstream start codon if multiple
                            in frame ones exist
  -h, --help                Show this message and exit.
```


## Metadata
- **Skill**: generated
