# meteor CWL Generation Report

## meteor_download

### Tool Description
Download a specific catalogue for Meteor analysis.

### Metadata
- **Docker Image**: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
- **Homepage**: https://github.com/metagenopolis/meteor
- **Package**: https://anaconda.org/channels/bioconda/packages/meteor/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/meteor/overview
- **Total Downloads**: 5.5K
- **Last updated**: 2025-12-12
- **GitHub**: https://github.com/metagenopolis/meteor
- **Stars**: N/A
### Original Help Text
```text
usage: Meteor download [-h] -i
                       {fc_1_3_gut,gg_13_6_caecal,clf_1_0_gut,hs_10_4_gut,hs_8_4_oral,hs_2_9_skin,mm_5_0_gut,oc_5_7_gut,rn_5_9_gut,ssc_9_3_gut}
                       [--fast] -o REF_DIR [-c]

options:
  -h, --help            show this help message and exit
  -i {fc_1_3_gut,gg_13_6_caecal,clf_1_0_gut,hs_10_4_gut,hs_8_4_oral,hs_2_9_skin,mm_5_0_gut,oc_5_7_gut,rn_5_9_gut,ssc_9_3_gut}
                        Select the catalogue to download.
  --fast                Select the short catalogue variant (only for taxonomic
                        profiling).
  -o REF_DIR            Directory where the downloaded catalogue is saved.
  -c                    Check the md5sum of the catalogue after download.
```


## meteor_fastq

### Tool Description
Create a fastq repository from a directory containing fastq files.

### Metadata
- **Docker Image**: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
- **Homepage**: https://github.com/metagenopolis/meteor
- **Package**: https://anaconda.org/channels/bioconda/packages/meteor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Meteor fastq [-h] -i INPUT_FASTQ_DIR [-p] [-m MASK_SAMPLE_NAME] -o
                    FASTQ_DIR

options:
  -h, --help           show this help message and exit
  -i INPUT_FASTQ_DIR   Directory containing all input fastq files with .fastq or .fq. extensions (gzip, bzip2 and xz compression accepted).
                       Paired-end files must be named : file_R1.[fastq/fq] & file_R2.[fastq/fq] or file_1.[fastq/fq] & file_2.[fastq/fq]
  -p                   Fastq files are paired.
  -m MASK_SAMPLE_NAME  Regular expression (between quotes) for extracting sample name.
  -o FASTQ_DIR         Directory where the fastq repository is created.
```


## meteor_mapping

### Tool Description
Map reads against a gene catalog and calculate raw gene counts.

### Metadata
- **Docker Image**: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
- **Homepage**: https://github.com/metagenopolis/meteor
- **Package**: https://anaconda.org/channels/bioconda/packages/meteor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Meteor mapping [-h] -i FASTQ_DIR -r REF_DIR -o MAPPING_DIR
                      [-p {end-to-end,local}] [--trim TRIM]
                      [--align ALIGNMENT_NUMBER]
                      [-c {total,smart_shared,unique}] [--core_size CORE_SIZE]
                      [--id IDENTITY_THRESHOLD] [--ka] [--kf] [--tmp TMP_PATH]
                      [-t THREADS]

options:
  -h, --help            show this help message and exit
  -i FASTQ_DIR          Directory corresponding to the sample to process.
                        (contains sequencing metadata files ending with _census_stage_0.json)
  -r REF_DIR            Directory corresponding to the gene catalog against which reads are mapped.
                        (contains a file ending with *_reference.json)
  -o MAPPING_DIR        Directory where mapping and raw gene counts of the sample are saved.
  -p {end-to-end,local}
                        Strategy to map reads against the catalogue (default: end-to-end).
  --trim TRIM           Trim reads exceeding TRIM bases before mapping (default: 80).
                        If 0, no trim.
  --align ALIGNMENT_NUMBER
                        Maximum number alignments to report for each read (default: 100)
  -c {total,smart_shared,unique}
                        Strategy to calculate raw gene counts (default: smart_shared).
  --core_size CORE_SIZE
                        Number of signature genes per species (MSP) used to estimate their respective abundance (default: 100).
  --id IDENTITY_THRESHOLD
                        Select only read alignments with a nucleotide identity >= IDENTITY_THRESHOLD (default: auto).
                        If 0.0, no filtering.
  --ka                  Keep raw bowtie2 output in cram format. Required for calculating gene counts with another strategy.
  --kf                  Keep filtered alignments on marker genes. Required for strain analysis.
  --tmp TMP_PATH        Directory where temporary files (e.g. cram) are stored
  -t THREADS            Number of alignment threads to launch (default: 1).
```


## meteor_profile

### Tool Description
Generate species and functional abundance tables from raw gene counts.

### Metadata
- **Docker Image**: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
- **Homepage**: https://github.com/metagenopolis/meteor
- **Package**: https://anaconda.org/channels/bioconda/packages/meteor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Meteor profile [-h] -i MAPPED_SAMPLE_DIR -r REF_DIR -o
                      PROFILED_SAMPLE_DIR [-l RAREFACTION_LEVEL] [--seed SEED]
                      [-n {coverage,fpkm,raw}] [-c COVERAGE_FACTOR]
                      [--core_size CORE_SIZE] [--msp_filter MSP_FILTER]
                      [--completeness COMPLETENESS]

options:
  -h, --help            show this help message and exit
  -i MAPPED_SAMPLE_DIR  Directory with raw gene counts of the sample to process.
                        (contains a metadata file ending with _census_stage_1.json)
  -r REF_DIR            Directory corresponding to the catalog used to generate raw gene counts.
                        (contains a file ending with *_reference.json)
  -o PROFILED_SAMPLE_DIR
                        Directory where species and functional abundance tables of the sample are saved.
  -l RAREFACTION_LEVEL  Rarefaction level. If <= 0, no rarefation is performed (default: 0).
  --seed SEED           Seed of the random number generator used for rarefaction (default: 1234).
  -n {coverage,fpkm,raw}
                        Normalization applied to raw gene counts (default: coverage).
  -c COVERAGE_FACTOR    Multiplication factor for coverage normalization (default: 100).
  --core_size CORE_SIZE
                        Number of signature genes per species (MSP) used to estimate their respective abundance (default: 100).
  --msp_filter MSP_FILTER
                        Minimal proportion of core genes detected in a sample to consider a species (MSP) as present (default: auto).
  --completeness COMPLETENESS
                        Cutoff above which a module is considered as present in a species.
                        Value between 0.0 and 1.0 (default: 0.9).
```


## meteor_merge

### Tool Description
Merge abundance tables from multiple samples into a single directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
- **Homepage**: https://github.com/metagenopolis/meteor
- **Package**: https://anaconda.org/channels/bioconda/packages/meteor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Meteor merge [-h] -i PROFILE_DIR -r REF_DIR [-a MIN_MSP_ABUNDANCE]
                    [-n MIN_MSP_OCCURRENCE] [-s] [-b] -o MERGING_DIR
                    [-p PREFIX] [-g]

options:
  -h, --help            show this help message and exit
  -i PROFILE_DIR        Directory containing subdirectories (one per sample) with abundance tables to be merged.
                        (each subdirectory contains a metadata file ending with _census_stage_2.json)
  -r REF_DIR            Directory corresponding to the gene catalog used to generate the abundance tables.
                        (contains a file ending with *_reference.json)
  -a MIN_MSP_ABUNDANCE  Minimum msp abundance (default >= 0.0)
  -n MIN_MSP_OCCURRENCE
                        Report only species (MSPs) occuring in at least n samples (default: 1).
  -s                    Remove samples with no detected species (MSPs) (default: False).
  -b                    Save the merged species abundance table in biom format (default: False).
  -o MERGING_DIR        Directory where the merged abundance tables are saved.
  -p PREFIX             Prefix added to output filenames (default: output).
  -g                    Merge gene abundance tables.
```


## meteor_strain

### Tool Description
Perform variant calling and strain analysis on mapped samples.

### Metadata
- **Docker Image**: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
- **Homepage**: https://github.com/metagenopolis/meteor
- **Package**: https://anaconda.org/channels/bioconda/packages/meteor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Meteor strain [-h] -i MAPPED_SAMPLE_DIR -r REF_DIR [-d MAX_DEPTH]
                     [-p MIN_DEPTH] [-s MIN_SNP_DEPTH] [-f MIN_FREQUENCY]
                     [-l PLOIDY] [-m MIN_MSP_COVERAGE] [-c MIN_GENE_COVERAGE]
                     [--core_size CORE_SIZE] -o STRAIN_DIR [--kc]
                     [--tmp TMP_PATH] [-t THREADS]

options:
  -h, --help            show this help message and exit
  -i MAPPED_SAMPLE_DIR  Path to the mapped sample directory.
  -r REF_DIR            Path to reference directory (Path containing
                        *_reference.json)
  -d MAX_DEPTH          Maximum number of reads taken in account (default:
                        100).
  -p MIN_DEPTH          Minimum depth (default: >= 3). Values should be
                        comprised between 1 and the maximum depth (10000 reads
                        are taken in account).
  -s MIN_SNP_DEPTH      Minimum snp depth (default: >= 3). Values should be
                        comprised between 1 and the maximum depth (10000 reads
                        are taken in account), take in account that s >= p.
  -f MIN_FREQUENCY      Minimum frequency for alleles (default: >= 0.10).
  -l PLOIDY             Ploidy (default: 1).
  -m MIN_MSP_COVERAGE   Minimum percentage of signature genes from the MSP
                        that are covered (default: >= 80%). Values should be
                        comprised between 1% and 100%
  -c MIN_GENE_COVERAGE  Minimum gene coverage from 0 to 1 (default: >= 0.5).
  --core_size CORE_SIZE
                        Number of signature genes per species (MSP) used to
                        estimate their respective abundance (default: 100).
  -o STRAIN_DIR         Path to output directory.
  --kc                  Keep consensus marker genes (default: False, set to
                        True to recompute strain)
  --tmp TMP_PATH        Path to the directory where temporary files are stored
  -t THREADS            Number of threads to perform variant calling (default:
                        1).
```


## meteor_tree

### Tool Description
Infer phylogenetic trees from strain directories using various models and output formats.

### Metadata
- **Docker Image**: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
- **Homepage**: https://github.com/metagenopolis/meteor
- **Package**: https://anaconda.org/channels/bioconda/packages/meteor/overview
- **Validation**: PASS

### Original Help Text
```text
usage: Meteor tree [-h] -i STRAIN_DIR [-g MAX_GAP] [-s MIN_INFO_SITES] [-r]
                   [-f {None,png,svg,pdf,txt}] [-w WIDTH] [-H HEIGHT] -o
                   TREE_DIR [--tmp TMP_PATH] [-t THREADS]

options:
  -h, --help            show this help message and exit
  -i STRAIN_DIR         Path to the strain directory.
  -g MAX_GAP            Removes sites constitued of >= cutoff gap character
                        (default: >= 1.0).
  -s MIN_INFO_SITES     Minimum number of informative sites in the alignment
                        (default: >= 10).
  -r                    Compute tn93 model (faster) (default: GTR).
  -f {None,png,svg,pdf,txt}
                        Output image format (default: None).
  -w WIDTH              Output image width (default: 500px).
  -H HEIGHT             Output image height (default: 500px).
  -o TREE_DIR           Path to output directory.
  --tmp TMP_PATH        Path to the directory where temporary files are stored
  -t THREADS            Number of threads when infering each tree (default:
                        1).
```


## meteor_test

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/meteor:2.0.22--pyhdfd78af_0
- **Homepage**: https://github.com/metagenopolis/meteor
- **Package**: https://anaconda.org/channels/bioconda/packages/meteor/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
usage: Meteor test [-h]

options:
  -h, --help  show this help message and exit
```

