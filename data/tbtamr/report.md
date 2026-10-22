# tbtamr CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| tbtamr_annotate | Not completed | snpEff cannot download its Mycobacterium tuberculosis database (snpeff.blob.core.windows.net unreachable), so the annotated VCF is empty |
| tbtamr_fq2vcf | Not completed | mapping and variant calling work on real ERR12118069 reads, but snpEff cannot download its database (snpeff.blob.core.windows.net unreachable), so the annotated VCF is empty |
| tbtamr_full | PASS | ran from the real ERR12118069 annotated VCF; read-based route needs the snpEff database |
| tbtamr_predict | PASS |  |
| tbtamr_search | PASS |  |

## tbtamr_search

### Tool Description
Search for variants in a catalog.

### Metadata
- **Docker Image**: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/MDU-PHL/tbtamr
- **Package**: https://anaconda.org/channels/bioconda/packages/tbtamr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tbtamr/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MDU-PHL/tbtamr
- **Stars**: N/A
### Original Help Text
```text
usage: tbtamr search [-h] [--catalog CATALOG]
                     [--catalog_config CATALOG_CONFIG]
                     --query QUERY [QUERY ...]

options:
  -h, --help            show this help message and exit
  --catalog, -c CATALOG
                        csv variant catalog (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/db/who_v2_catalog.csv)
  --catalog_config, -cfg CATALOG_CONFIG
                        json file indicating the relevant column settings for
                        interpretation of the catalog file. (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/configs/db_config.json)
  --query, -q QUERY [QUERY ...]
                        The variant to search for. Multiple allowed separated
                        by a space. (default: None)
```


## tbtamr_predict

### Tool Description
Predict resistance profiles and lineages from VCF files.

### Metadata
- **Docker Image**: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/MDU-PHL/tbtamr
- **Package**: https://anaconda.org/channels/bioconda/packages/tbtamr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tbtamr predict [-h] [--seq_id SEQ_ID] [--vcf VCF] [--catalog CATALOG]
                      [--catalog_config CATALOG_CONFIG]
                      [--interpretation_criteria INTERPRETATION_CRITERIA]
                      [--barcode BARCODE] [--reference_file REFERENCE_FILE]
                      [--classification_criteria CLASSIFICATION_CRITERIA]
                      [--force] [--call_lineage] [--cascade] [--tmp TMP]

options:
  -h, --help            show this help message and exit
  --seq_id, -s SEQ_ID   Sequence name. (default: tbtamr)
  --vcf VCF             VCF file generated using the H37rV v3 reference genome
                        (default: )
  --catalog, -c CATALOG
                        csv variant catalog (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/db/who_v2_catalog.csv)
  --catalog_config, -cfg CATALOG_CONFIG
                        json file indicating the relevant column settings for
                        interpretation of the catalog file. (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/configs/db_config.json)
  --interpretation_criteria, -r INTERPRETATION_CRITERIA
                        csv file with rules for predicting resistance profiles
                        from genomic data. (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/configs/interpretation_criteria.csv)
  --barcode, -b BARCODE
                        Barcode to use for lineage calling and speciation.
                        (default: /usr/local/lib/python3.13/site-
                        packages/tbtamr/db/tbtamr.barcode.bed)
  --reference_file, -ref REFERENCE_FILE
                        Reference file to use for calling lineage. (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/db/tbtamr.fasta)
  --classification_criteria, -cr CLASSIFICATION_CRITERIA
                        csv file with rules for predicting resistance profiles
                        from genomic data. (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/configs/classification_criteria.csv)
  --force, -f           Force replace an existing folder. (default: False)
  --call_lineage        Use pathogen profiler to call lineage (default: False)
  --cascade             If you would like to apply cascade reporting
                        structure. (default: False)
  --tmp TMP             temp directory to use (default: /tmp)
```


## tbtamr_annotate

### Tool Description
Annotate a BAM file with sequence ID and VCF information.

### Metadata
- **Docker Image**: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/MDU-PHL/tbtamr
- **Package**: https://anaconda.org/channels/bioconda/packages/tbtamr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tbtamr annotate [-h] [--seq_id SEQ_ID] [--vcf VCF]

options:
  -h, --help           show this help message and exit
  --seq_id, -s SEQ_ID  Sequence name. (default: tbtamr)
  --vcf VCF            VCF file generated using the H37rV v3 reference genome
                       (default: )
```


## tbtamr_fq2vcf

### Tool Description
Generate an annotated vcf file from paired-end fastq files - NO report generated.

### Metadata
- **Docker Image**: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/MDU-PHL/tbtamr
- **Package**: https://anaconda.org/channels/bioconda/packages/tbtamr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tbtamr fq2vcf [-h] [--seq_id SEQ_ID] [--read1 READ1] [--read2 READ2]
                     [--min_depth MIN_DEPTH] [--min_frac MIN_FRAC]
                     [--threads THREADS] [--ram RAM] [--keep] [--force]
                     [--tmp TMP]

options:
  -h, --help            show this help message and exit
  --seq_id, -s SEQ_ID   Sequence name. (default: tbtamr)
  --read1, -1 READ1     Path to read 1 - not required if vcf is supplied
                        (default: )
  --read2, -2 READ2     Path to read 2 - not required if vcf is supplied
                        (default: )
  --min_depth, -md MIN_DEPTH
                        Minimum depth to call a variant - only required if
                        reads supplied as input (default: 20)
  --min_frac, -mf MIN_FRAC
                        Minimum proportion to call a variant (0-1) - only
                        required if reads supplied as input (default: 0.1)
  --threads, -t THREADS
                        Threads to use for generation of vcf file - only
                        required if reads supplied as input (default: 8)
  --ram RAM             Max ram to use - only required if reads supplied as
                        input (default: 8)
  --keep, -k            Keep accessory files generated from alignment for
                        further use. (default: False)
  --force, -f           Force replace an existing folder. (default: False)
  --tmp TMP             temp directory to use (default: /tmp)
```


## tbtamr_full

### Tool Description
Predict AMR results from reads or vcf

### Metadata
- **Docker Image**: quay.io/biocontainers/tbtamr:1.0.3--pyhdfd78af_0
- **Homepage**: https://github.com/MDU-PHL/tbtamr
- **Package**: https://anaconda.org/channels/bioconda/packages/tbtamr/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tbtamr full [-h] [--seq_id SEQ_ID] [--vcf VCF] [--read1 READ1]
                   [--read2 READ2] [--catalog CATALOG]
                   [--catalog_config CATALOG_CONFIG]
                   [--interpretation_criteria INTERPRETATION_CRITERIA]
                   [--barcode BARCODE] [--reference_file REFERENCE_FILE]
                   [--classification_criteria CLASSIFICATION_CRITERIA]
                   [--call_lineage] [--min_depth MIN_DEPTH]
                   [--min_frac MIN_FRAC] [--threads THREADS] [--ram RAM]
                   [--keep] [--force] [--cascade] [--tmp TMP]

options:
  -h, --help            show this help message and exit
  --seq_id, -s SEQ_ID   Sequence name. (default: tbtamr)
  --vcf VCF             VCF file generated using the H37rV v3 reference genome
                        (default: )
  --read1, -1 READ1     Path to read 1 - not required if vcf is supplied
                        (default: )
  --read2, -2 READ2     Path to read 2 - not required if vcf is supplied
                        (default: )
  --catalog, -c CATALOG
                        csv variant catalog (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/db/who_v2_catalog.csv)
  --catalog_config, -cfg CATALOG_CONFIG
                        json file indicating the relevant column settings for
                        interpretation of the catalog file. (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/configs/db_config.json)
  --interpretation_criteria, -r INTERPRETATION_CRITERIA
                        csv file with rules for predicting resistance profiles
                        from genomic data. (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/configs/interpretation_criteria.csv)
  --barcode, -b BARCODE
                        Barcode to use for lineage calling and speciation.
                        (default: /usr/local/lib/python3.13/site-
                        packages/tbtamr/db/tbtamr.barcode.bed)
  --reference_file, -ref REFERENCE_FILE
                        Reference file to use for calling lineage. (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/db/tbtamr.fasta)
  --classification_criteria, -cr CLASSIFICATION_CRITERIA
                        csv file with rules for predicting resistance profiles
                        from genomic data. (default:
                        /usr/local/lib/python3.13/site-
                        packages/tbtamr/configs/classification_criteria.csv)
  --call_lineage        Use pathogen profiler to call lineage (default: False)
  --min_depth, -md MIN_DEPTH
                        Minimum depth to call a variant - only required if
                        reads supplied as input (default: 20)
  --min_frac, -mf MIN_FRAC
                        Minimum proportion to call a variant (0-1) - only
                        required if reads supplied as input (default: 0.1)
  --threads, -t THREADS
                        Threads to use for generation of vcf file - only
                        required if reads supplied as input (default: 8)
  --ram RAM             Max ram to use - only required if reads supplied as
                        input (default: 8)
  --keep, -k            Keep accessory files generated from alignment for
                        further use. (default: False)
  --force, -f           Force replace an existing folder. (default: False)
  --cascade             If you would like to apply cascade reporting
                        structure. (default: False)
  --tmp TMP             temp directory to use (default: /tmp)
```


## Metadata
- **Skill**: generated
