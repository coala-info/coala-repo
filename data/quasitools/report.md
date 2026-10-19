# quasitools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| quasitools_aacoverage | PASS | quasitools repo test data; coverage CSV identical to the repo expected file; added BAM index secondary files |
| quasitools_call_aavar | PASS | quasitools repo align.bam with variants and mutation database; AAVF report written with the expected RT mutations (K103N region) |
| quasitools_call_codonvar | PASS | quasitools repo align.bam, offset 1269; codon variant CSV lists K103N at 7.79% with coverage 154, as in the repo expected file |
| quasitools_call_ntvar | PASS | quasitools repo align.bam; VCF with 1509 nucleotide variants (DP, AF) written |
| quasitools_complexity_bam | PASS | quasitools repo complexity BAM and reference, k=3; per-position complexity CSV written |
| quasitools_complexity_fasta | PASS | quasitools repo complexity.fasta; complexity CSV with haplotype, entropy and Simpson values written |
| quasitools_consensus | PASS | quasitools repo HIV pol BAM; 2679-base consensus matches the HXB2 reference exactly over the covered region; added BAM index secondary files |
| quasitools_distance | PASS | quasitools repo test BAMs quasi1 and quasi2; symmetric angular distance matrix 0.0063 between them, similarity mode also works; reference changed to File, BAM indexes added |
| quasitools_dnds | PASS | quasitools repo mutant_types.csv with offset 1269; dn/ds report identical to the repo expected file; removed invented options and used --output |
| quasitools_drmutations | PASS | quasitools repo test data; report finds K103N at 7.79% with coverage 154, same as the repo expected dr_report; fixed --output flag and BAM index |
| quasitools_hydra | PASS | quasitools repo forward and reverse FASTQ; full run gives alignment, VCF, coverage, consensus and a drug resistance report listing K103N and other RT mutations |
| quasitools_quality | PASS | quasitools repo forward and reverse FASTQ; reads combined and filtered (min length 100, N masked) |

## quasitools_aacoverage

### Tool Description
This script builds an amino acid census and returns its coverage. The BAM alignment file corresponds to a pileup of sequences aligned to the REFERENCE. A BAM index file (.bai) must also be present and, except for the extension, have the same name as the BAM file. The REFERENCE must be in FASTA format. The BED4_FILE must be a BED file with at least 4 columns and specify the gene locations within the REFERENCE.
The output is in CSV format.

### Metadata
- **Docker Image**: quay.io/biocontainers/quasitools:0.7.0--py_0
- **Homepage**: https://github.com/phac-nml/quasitools/
- **Package**: https://anaconda.org/channels/bioconda/packages/quasitools/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/quasitools/overview
- **Total Downloads**: 82.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/phac-nml/quasitools
- **Stars**: N/A
### Original Help Text
```text
Usage: quasitools aacoverage [OPTIONS] BAM REFERENCE BED4_FILE

  This script builds an amino acid census and returns its coverage. The BAM
  alignment file corresponds to a pileup of sequences aligned to the
  REFERENCE. A BAM index file (.bai) must also be present and, except for
  the extension, have the same name as the BAM file. The REFERENCE must be
  in FASTA format. The BED4_FILE must be a BED file with at least 4 columns
  and specify the gene locations within the REFERENCE.

  The output is in CSV format.

Options:
  -o, --output FILENAME
  --help                 Show this message and exit.
```


## quasitools_consensus

### Tool Description
Generate consensus sequences from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/quasitools:0.7.0--py_0
- **Homepage**: https://github.com/phac-nml/quasitools/
- **Package**: https://anaconda.org/channels/bioconda/packages/quasitools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: quasitools consensus [OPTIONS] BAM REFERENCE

Options:
  -p, --percentage INTEGER  percentage to include base in mixture.
  -i, --id TEXT             specify default FASTA sequence identifier to be
                            used for sequences without an RG tag.
  -o, --output FILENAME
  --help                    Show this message and exit.
```


## quasitools_distance

### Tool Description
Quasitools distance produces a measure of evolutionary distance [0 - 1] between quasispecies, computed using the angular cosine distance function defined below.

### Metadata
- **Docker Image**: quay.io/biocontainers/quasitools:0.7.0--py_0
- **Homepage**: https://github.com/phac-nml/quasitools/
- **Package**: https://anaconda.org/channels/bioconda/packages/quasitools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: quasitools distance [OPTIONS] REFERENCE [BAM]...

  Quasitools distance produces a measure of evolutionary distance [0 - 1]
  between quasispecies, computed using the angular cosine distance function
  defined below.

  Cosine similarity = (u * v) / ( ||u|| * ||v|| )

  Angular Cosine Distance = 2 * ACOS(Cosine similarity) / PI

  The tool outputs by default an angular cosine distance matrix. Use the
  flag defined below to instead output a similarity matrix.

  By default the data is normalized and all regions of the pileup with no
  coverage are removed.

  It is possible to truncate only the contiguous start and end regions of
  the pileup that have no coverage, or keep all no coverage regions in the
  pileup.

  Normalization is done dividing base read counts (A, C, T, G) inside every
  4-tuple by the sum of the read counts inside the same tuple. The
  normalized read counts inside each 4-tuple sum to one.

Options:
  -n, --normalize / -dn, --dont_normalize
                                  Normalize read count data so that the read
                                  counts per 4-tuple (A, C, T, G) sum to one.
  -od, --output_distance / -os, --output_similarity
                                  Output an angular distance matrix (by
                                  default), or output a cosine similarity
                                  matrix (cosine similarity is not a metric)
  -s, --startpos INTEGER          Set the start base position of the reference
                                  to use in the distance or similarity
                                  calculation. Start position is one-indexed.
                                  I.e. it must be between one and the total
                                  length of the reference sequence(s),
                                  inclusive.
  -e, --endpos INTEGER            Set the end base position of the reference
                                  to use in the distance or similarity
                                  calculation. End position is one-indexed.
                                  I.e. it must be between one and the total
                                  length of the reference sequence(s),
                                  inclusive.
  -o, --output FILENAME           Output the quasispecies distance or
                                  similarity matrix in CSV format in a file.
  -t, --truncate                  Ignore contiguous start and end pileup
                                  regions with no coverage.
  -r, --remove_no_coverage        Ignore all pileup regions with no coverage.
  -k, --keep_no_coverage          Do not ignore pileup regions with no
                                  coverage.
  --help                          Show this message and exit.
```


## quasitools_dnds

### Tool Description
Calculate dN/dS ratios for coding sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/quasitools:0.7.0--py_0
- **Homepage**: https://github.com/phac-nml/quasitools/
- **Package**: https://anaconda.org/channels/bioconda/packages/quasitools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: quasitools dnds [OPTIONS] CSV REFERENCE OFFSET
Try "quasitools dnds --help" for help.

Error: no such option: --h  Did you mean --help?
```


## quasitools_drmutations

### Tool Description
Detects drug-resistant mutations from BAM files.

### Metadata
- **Docker Image**: quay.io/biocontainers/quasitools:0.7.0--py_0
- **Homepage**: https://github.com/phac-nml/quasitools/
- **Package**: https://anaconda.org/channels/bioconda/packages/quasitools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: quasitools drmutations [OPTIONS] BAM REFERENCE VARIANTS BED4_FILE
                              MUTATION_DB

Options:
  -f, --min_freq FLOAT            the minimum required frequency.
  -t, --reporting_threshold INTEGER
                                  the minimum percentage required for an entry
                                  in the drugresistant report.
  -o, --output FILENAME
  --help                          Show this message and exit.
```


## quasitools_hydra

### Tool Description
Generate a mixed base consensus sequence.

### Metadata
- **Docker Image**: quay.io/biocontainers/quasitools:0.7.0--py_0
- **Homepage**: https://github.com/phac-nml/quasitools/
- **Package**: https://anaconda.org/channels/bioconda/packages/quasitools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: quasitools hydra [OPTIONS] FORWARD [REVERSE]

Options:
  -o, --output_dir DIRECTORY      [required]
  -m, --mutation_db FILE
  -rt, --reporting_threshold INTEGER RANGE
                                  Minimum mutation frequency percent to
                                  report.
  -gc, --generate_consensus       Generate a mixed base consensus sequence.
  -cp, --consensus_pct INTEGER RANGE
                                  Minimum percentage a base needs to be
                                  incorporated into the consensus sequence.
  -q, --quiet                     Suppress all normal output.
  -tr, --trim_reads               Iteratively trim reads based on filter
                                  values if enabled. Remove reads which do not
                                  meet filter values if disabled.
  -mr, --mask_reads               Mask low coverage regions in reads if below
                                  minimum read quality. This option and --ns
                                  cannot be both enabled simultaneously.
  -rq, --min_read_qual INTEGER    Minimum quality for a position in a read to
                                  be masked.
  -lc, --length_cutoff INTEGER    Reads which fall short of the specified
                                  length will be filtered out.
  -sc, --score_cutoff INTEGER     Reads that have a median or mean quality
                                  score (depending on the score type
                                  specified) less than the score cutoff value
                                  will be filtered out.
  -me, --median / -mn, --mean     Use either median score (default) or mean
                                  score for the score cutoff value.
  -n, --ns                        Flag to enable the filtering of n's.  This
                                  option and --mask_reads cannot be both
                                  enabled simultaneously.
  -e, --error_rate FLOAT          Error rate for the sequencing platform.
  -vq, --min_variant_qual INTEGER
                                  Minimum quality for variant to be considered
                                  later on in the pipeline.
  -md, --min_dp INTEGER           Minimum required read depth for variant to
                                  be considered later on in the pipeline.
  -ma, --min_ac INTEGER           The minimum required allele count for
                                  variant to be considered later on in the
                                  pipeline.
  -mf, --min_freq FLOAT           The minimum required frequency for mutation
                                  to be considered in drug resistance report.
  -i, --id TEXT                   Specify FASTA sequence identifier to be used
                                  in the consensus report.
  --help                          Show this message and exit.
```


## quasitools_quality

### Tool Description
Quasitools quality performs quality control on FASTQ reads and outputs the
  filtered FASTQ reads in the specified directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/quasitools:0.7.0--py_0
- **Homepage**: https://github.com/phac-nml/quasitools/
- **Package**: https://anaconda.org/channels/bioconda/packages/quasitools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: quasitools quality [OPTIONS] FORWARD [REVERSE]

  Quasitools quality performs quality control on FASTQ reads and outputs the
  filtered FASTQ reads in the specified directory.

Options:
  -o, --output_dir DIRECTORY    [required]
  -tr, --trim_reads             Iteratively trim reads based on filter values
                                if enabled. Remove reads which do not meet
                                filter values if disabled.
  -mr, --mask_reads             Mask low quality regions in reads if below
                                minimum read quality. This option and --ns
                                cannot be both enabled simultaneously.
  -rq, --min_read_qual INTEGER  Minimum quality for positions in read if
                                masking is enabled.
  -lc, --length_cutoff INTEGER  Reads which fall short of the specified length
                                will be filtered out.
  -sc, --score_cutoff INTEGER   Reads that have a median or mean quality score
                                (depending on the score type specified) less
                                than the score cutoff value will be filtered
                                out.
  -me, --median / -mn, --mean   Use either median score (default) or mean
                                score for the score cutoff value.
  -n, --ns                      Flag to enable the filtering of n's. This
                                option and --mask_reads cannot be both enabled
                                simultaneously.
  --help                        Show this message and exit.
```


## quasitools_call_ntvar

### Tool Description
Call nucleotide variants from a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/quasitools:0.7.0--py_0
- **Homepage**: https://github.com/phac-nml/quasitools/
- **Package**: https://anaconda.org/channels/bioconda/packages/quasitools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: quasitools call ntvar [OPTIONS] BAM REFERENCE

Options:
  -e, --error_rate FLOAT  estimated sequencing error rate.
  -o, --output FILENAME
  --help                  Show this message and exit.
```

## quasitools_call_aavar

### Tool Description
Identify amino acid mutations from a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/quasitools:0.7.0--py_0
- **Homepage**: https://github.com/phac-nml/quasitools/
- **Package**: https://anaconda.org/channels/bioconda/packages/quasitools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: quasitools call aavar [OPTIONS] BAM REFERENCE BED4_FILE [VARIANTS]
                             [MUTATION_DB]

Options:
  -f, --min_freq FLOAT    the minimum required frequency.
  -e, --error_rate FLOAT  estimated sequencing error rate.
  -o, --output FILENAME
  --help                  Show this message and exit.
```

## quasitools_call_codonvar

### Tool Description
Call codon variants from a BAM file.

### Metadata
- **Docker Image**: quay.io/biocontainers/quasitools:0.7.0--py_0
- **Homepage**: https://github.com/phac-nml/quasitools/
- **Package**: https://anaconda.org/channels/bioconda/packages/quasitools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: quasitools call codonvar [OPTIONS] BAM REFERENCE OFFSET BED4_FILE
                                [VARIANTS]

Options:
  -e, --error_rate FLOAT  estimated sequencing error rate.
  -o, --output FILENAME
  --help                  Show this message and exit.
```

## quasitools_complexity_fasta

### Tool Description
Report the per-amplicon complexity of a quasispecies FASTA file.

### Metadata
- **Docker Image**: quay.io/biocontainers/quasitools:0.7.0--py_0
- **Homepage**: https://github.com/phac-nml/quasitools/
- **Package**: https://anaconda.org/channels/bioconda/packages/quasitools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: quasitools complexity fasta [OPTIONS] FASTA_LOCATION

  Reports the per-amplicon (fasta)  or k-mer complexity of the pileup, for
  each k-mer position in the reference complexity (bam and reference) of a
  quasispecies using several measures outlined in the following work:

  Gregori, Josep, et al. "Viral quasispecies complexity measures." Virology
  493 (2016): 227-237.

Options:
  -o, --output_location PATH  Output the quasispecies complexity in CSV format
                              to the specified file.
  --help                      Show this message and exit.
```

## quasitools_complexity_bam

### Tool Description
Report the k-mer complexity of the pileup for each k-mer position in the reference.

### Metadata
- **Docker Image**: quay.io/biocontainers/quasitools:0.7.0--py_0
- **Homepage**: https://github.com/phac-nml/quasitools/
- **Package**: https://anaconda.org/channels/bioconda/packages/quasitools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: quasitools complexity bam [OPTIONS] REFERENCE_LOCATION BAM_LOCATION K

  Reports the per-amplicon (fasta)  or k-mer complexity of the pileup, for
  each k-mer position in the reference complexity (bam and reference) of a
  quasispecies using several measures outlined in the following work:

  Gregori, Josep, et al. "Viral quasispecies complexity measures." Virology
  493 (2016): 227-237.

Options:
  -f, --haplotype_filter FLOAT  User defined A filter between 0 and 100,
                                inclusive. Abundancesbelow the filter size
                                will be removed from each positionallist. The
                                default is 0 (i.e. no filtering).
  -o, --output_location PATH    Output the quasispecies complexity in CSV
                                format to the specified file.
  --help                        Show this message and exit.
```

## Metadata
- **Skill**: generated
