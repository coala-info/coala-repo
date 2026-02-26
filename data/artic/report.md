# artic CWL Generation Report

## artic_minion

### Tool Description
ARTIC pipeline for MinION data

### Metadata
- **Docker Image**: quay.io/biocontainers/artic:1.8.5--pyhdfd78af_0
- **Homepage**: https://github.com/artic-network/fieldbioinformatics
- **Package**: https://anaconda.org/channels/bioconda/packages/artic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/artic/overview
- **Total Downloads**: 40.7K
- **Last updated**: 2026-02-24
- **GitHub**: https://github.com/artic-network/fieldbioinformatics
- **Stars**: N/A
### Original Help Text
```text
usage: artic minion [-h] [-q]
                    [--model {r1041_e82_260bps_fast_g632,r1041_e82_400bps_fast_g632,r1041_e82_400bps_sup_g615,r1041_e82_260bps_hac_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_sup_v400,r1041_e82_260bps_hac_v400,r1041_e82_400bps_hac_g632,r1041_e82_400bps_sup_v410,r1041_e82_260bps_hac_v410,r1041_e82_400bps_hac_v400,r1041_e82_400bps_sup_v420,r1041_e82_260bps_sup_g632,r1041_e82_400bps_hac_v410,r1041_e82_400bps_sup_v430,r1041_e82_260bps_sup_v400,r1041_e82_400bps_hac_v420,r1041_e82_400bps_sup_v500,r1041_e82_260bps_sup_v410,r1041_e82_400bps_hac_v430,r104_e81_hac_g5015,r1041_e82_400bps_hac_v500,r104_e81_sup_g5015,r1041_e82_400bps_hac_v520,r1041_e82_400bps_sup_v520,r941_prom_sup_g5014,r941_prom_hac_g360+g422}]
                    [--model-dir model_path] [--min-mapq MIN_MAPQ]
                    [--normalise NORMALISE]
                    [--primer-match-threshold PRIMER_MATCH_THRESHOLD]
                    [--allow-mismatched-primers] [--min-depth MIN_DEPTH]
                    [--threads THREADS] [--scheme-directory scheme_directory]
                    [--scheme-name scheme_name]
                    [--scheme-length scheme_length] [--scheme-version vX.X.X]
                    [--bed bed] [--ref REF] --read-file read_file
                    [--no-indels] [--no-frameshifts] [--align-consensus]
                    [--linearise-fasta] [--dry-run]
                    sample

positional arguments:
  sample                The name of the sample

options:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  --model {r1041_e82_260bps_fast_g632,r1041_e82_400bps_fast_g632,r1041_e82_400bps_sup_g615,r1041_e82_260bps_hac_g632,r1041_e82_400bps_hac_g615,r1041_e82_400bps_sup_v400,r1041_e82_260bps_hac_v400,r1041_e82_400bps_hac_g632,r1041_e82_400bps_sup_v410,r1041_e82_260bps_hac_v410,r1041_e82_400bps_hac_v400,r1041_e82_400bps_sup_v420,r1041_e82_260bps_sup_g632,r1041_e82_400bps_hac_v410,r1041_e82_400bps_sup_v430,r1041_e82_260bps_sup_v400,r1041_e82_400bps_hac_v420,r1041_e82_400bps_sup_v500,r1041_e82_260bps_sup_v410,r1041_e82_400bps_hac_v430,r104_e81_hac_g5015,r1041_e82_400bps_hac_v500,r104_e81_sup_g5015,r1041_e82_400bps_hac_v520,r1041_e82_400bps_sup_v520,r941_prom_sup_g5014,r941_prom_hac_g360+g422}
                        The model to use for clair3, if not provided the
                        pipeline will try to figure it out the appropriate
                        model from the read fastq
  --model-dir model_path
                        Path containing clair3 models, defaults to models
                        packaged with conda installation (default:
                        $CONDA_PREFIX/bin/models/)
  --min-mapq MIN_MAPQ   Minimum mapping quality to consider (default: 20)
  --normalise NORMALISE
                        Normalise down to moderate coverage to save runtime
                        (default: 100, deactivate with `--normalise 0`)
  --primer-match-threshold PRIMER_MATCH_THRESHOLD
                        Allow fuzzy primer matching within this threshold
                        (default: 35)
  --allow-mismatched-primers
                        Do not remove reads which appear to have mismatched
                        primers (default: False)
  --min-depth MIN_DEPTH
                        Minimum coverage required for a position to be
                        included in the consensus sequence (default: 20)
  --threads THREADS     Number of threads (default: 8)
  --read-file read_file
                        FASTQ file containing reads
  --no-indels           Do not report InDels (uses SNP-only mode of
                        nanopolish/medaka)
  --no-frameshifts      Remove variants which induce frameshifts (ignored when
                        --no-indels set)
  --align-consensus     Run a mafft alignment of consensus to reference after
                        generation
  --linearise-fasta     Output linearised (unwrapped) FASTA consensus files
  --dry-run

Remote Scheme Options:
  Options for automagically fetching primer schemes from the scheme
  repository (https://github.com/quick-lab/primerschemes)

  --scheme-directory scheme_directory
                        Default scheme directory (default: //primer-schemes)
  --scheme-name scheme_name
                        Name of the scheme, e.g. sars-cov-2, mpxv to fetch
                        from the scheme repository (https://github.com/quick-
                        lab/primerschemes)
  --scheme-length scheme_length
                        Length of the scheme to fetch from the scheme
                        repository (https://github.com/quick-
                        lab/primerschemes). This is only required if the
                        --scheme-name has multiple possible lengths.
  --scheme-version vX.X.X
                        Primer scheme version

Local Scheme Options:
  Options for providing a local primer scheme and reference sequence (BED
  file and FASTA file) directly to the pipeline

  --bed bed             BED file containing primer scheme
  --ref REF             Reference sequence for the scheme
```


## artic_guppyplex

### Tool Description
Basecalled and demultiplexed (guppy) results directory

### Metadata
- **Docker Image**: quay.io/biocontainers/artic:1.8.5--pyhdfd78af_0
- **Homepage**: https://github.com/artic-network/fieldbioinformatics
- **Package**: https://anaconda.org/channels/bioconda/packages/artic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: artic guppyplex [-h] [-q] --directory directory
                       [--max-length max_length] [--min-length min_length]
                       [--quality quality] [--sample sample]
                       [--skip-quality-check] [--prefix PREFIX]
                       [--output output]

options:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  --directory directory
                        Basecalled and demultiplexed (guppy) results directory
  --max-length max_length
                        remove reads greater than read length
  --min-length min_length
                        remove reads less than read length
  --quality quality     remove reads against this quality filter
  --sample sample       sampling frequency for random sample of sequence to
                        reduce excess
  --skip-quality-check  Do not filter on quality score (speeds up)
  --prefix PREFIX       Prefix for guppyplex files
  --output output       FASTQ file to write
```


## artic_filter

### Tool Description
Filter FASTQ reads based on length.

### Metadata
- **Docker Image**: quay.io/biocontainers/artic:1.8.5--pyhdfd78af_0
- **Homepage**: https://github.com/artic-network/fieldbioinformatics
- **Package**: https://anaconda.org/channels/bioconda/packages/artic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: artic filter [-h] [-q] [--max-length max_length]
                    [--min-length min_length]
                    filename

positional arguments:
  filename              FASTQ file.

options:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  --max-length max_length
                        remove reads greater than read length
  --min-length min_length
                        remove reads less than read length
```


## artic_rampart

### Tool Description
RAMPART is a tool for the analysis of sequencing data from pathogen surveillance.

### Metadata
- **Docker Image**: quay.io/biocontainers/artic:1.8.5--pyhdfd78af_0
- **Homepage**: https://github.com/artic-network/fieldbioinformatics
- **Package**: https://anaconda.org/channels/bioconda/packages/artic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: artic rampart [-h] [-q] [--protocol-directory protocol_directory]
                     [--run-directory run_directory]

options:
  -h, --help            show this help message and exit
  -q, --quiet           Do not output warnings to stderr
  --protocol-directory protocol_directory
                        The RAMPART protocols directory.
  --run-directory run_directory
                        The run directory
```


## artic_export

### Tool Description
Export artic results to various formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/artic:1.8.5--pyhdfd78af_0
- **Homepage**: https://github.com/artic-network/fieldbioinformatics
- **Package**: https://anaconda.org/channels/bioconda/packages/artic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: artic export [-h] [-q]
                    prefix bamfile sequencing_summary fast5_directory
                    output_directory

positional arguments:
  prefix
  bamfile
  sequencing_summary
  fast5_directory
  output_directory

options:
  -h, --help          show this help message and exit
  -q, --quiet         Do not output warnings to stderr
```


## artic_run

### Tool Description
Run the artic pipeline

### Metadata
- **Docker Image**: quay.io/biocontainers/artic:1.8.5--pyhdfd78af_0
- **Homepage**: https://github.com/artic-network/fieldbioinformatics
- **Package**: https://anaconda.org/channels/bioconda/packages/artic/overview
- **Validation**: PASS

### Original Help Text
```text
usage: artic run [-h] [-q]

options:
  -h, --help   show this help message and exit
  -q, --quiet  Do not output warnings to stderr
```

