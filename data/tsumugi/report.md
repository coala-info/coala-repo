# tsumugi CWL Generation Report

## tsumugi_run

### Tool Description
TSUMUGI pipeline for analyzing IMPC statistical results and generating phenotype-disease associations.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/akikuno/TSUMUGI-dev
- **Package**: https://anaconda.org/channels/bioconda/packages/tsumugi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tsumugi/overview
- **Total Downloads**: 124
- **Last updated**: 2026-02-05
- **GitHub**: https://github.com/akikuno/TSUMUGI-dev
- **Stars**: N/A
### Original Help Text
```text
usage: tsumugi run [-h] -o OUTPUT_DIR -s STATISTICAL_RESULTS [-m MP_OBO]
                   [-i IMPC_PHENODIGM] [-t THREADS]

options:
  -h, --help            show this help message and exit
  -o, --output_dir OUTPUT_DIR
                        Output directory for TSUMUGI results.
                        All generated files (intermediate and final results) will be saved here.
  -s, --statistical_results STATISTICAL_RESULTS
                        Path to IMPC statistical_results_ALL.csv file.
                        This file contains statistical test results (effect sizes, p-values, etc.) for all IMPC phenotyping experiments.
                        If not available, download 'statistical-results-ALL.csv.gz' manually from:
                        https://ftp.ebi.ac.uk/pub/databases/impc/all-data-releases/latest/TSUMUGI-results/
  -m, --mp_obo MP_OBO   Path to Mammalian Phenotype ontology file (mp.obo).
                        Used to map and infer hierarchical relationships among MP terms.
                        If not available, download 'mp.obo' manually from:
                        https://obofoundry.org/ontology/mp.html
  -i, --impc_phenodigm IMPC_PHENODIGM
                        Path to IMPC Phenodigm annotation file (impc_phenodigm.csv).
                        This file links mouse phenotypes to human diseases based on Phenodigm similarity.
                        If not available, download manually from:
                        https://diseasemodels.research.its.qmul.ac.uk/
  -t, --threads THREADS
                        Number of threads to use for TSUMUGI pipeline.
                        If not specified, defaults to 1.
```


## tsumugi_mp

### Tool Description
Filter gene pairs based on Mammalian Phenotype ontology terms and annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/akikuno/TSUMUGI-dev
- **Package**: https://anaconda.org/channels/bioconda/packages/tsumugi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tsumugi mp [-h] (-i MP_ID | -e MP_ID) [-g | -p] [-m MP_OBO]
                  [-a PATH_GENEWISE] [--in PATH_PAIRWISE]
                  [--life_stage LIFE_STAGE] [--sex SEX] [--zygosity ZYGOSITY]

options:
  -h, --help            show this help message and exit
  -i, --include MP_ID   Include gene pairs that share the specified MP term (descendants included).
                        Example: -i MP:0001146
  -e, --exclude MP_ID   Exclude gene pairs that (when measured) lack the specified MP term (descendants included).
                        Example: -e MP:0001146
  -g, --genewise        Filter by number of phenotypes per KO mouse
  -p, --pairwise        Filter by number of shared phenotypes between KO pairs
  -m, --mp_obo MP_OBO   Path to Mammalian Phenotype ontology file (mp.obo).
                        Used to map and infer hierarchical relationships among MP terms.
                        If not available, download 'mp.obo' manually from:
                        https://obofoundry.org/ontology/mp.html
  -a, --genewise_annotations PATH_GENEWISE
                        Path to the 'genewise_phenotype_annotations' file (JSONL or JSONL.gz).
                        Required when using '-e/--exclude' to determine genes that were measured
                        and showed no phenotype for the target MP term.
  --in PATH_PAIRWISE    Path to 'pairwise_similarity_annotations' file (JSONL or JSONL.gz).
                        If omitted, data are read from STDIN.
  --life_stage LIFE_STAGE
                        Filter by life stage. 'Embryo', 'Early', 'Interval', and 'Late'.
  --sex SEX             Filter by sexual dimorphism. 'Male' or 'Female'.
  --zygosity ZYGOSITY   Filter by zygosity.  'Homo', 'Hetero' or 'Hemi'.
```


## tsumugi_count

### Tool Description
Filter genes based on the number of detected phenotypes per KO or shared between KO pairs.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/akikuno/TSUMUGI-dev
- **Package**: https://anaconda.org/channels/bioconda/packages/tsumugi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tsumugi count [-h] (-g | -p) [--min MIN] [--max MAX]
                     [--in PATH_PAIRWISE] [-a PATH_GENEWISE]

Filter genes based on the number of detected phenotypes per KO or shared
between KO pairs.

options:
  -h, --help            show this help message and exit
  -g, --genewise        Filter by number of phenotypes per KO mouse
  -p, --pairwise        Filter by number of shared phenotypes between KO pairs
  --min MIN             Minimum number threshold
  --max MAX             Maximum number threshold
  --in PATH_PAIRWISE    Path to 'pairwise_similarity_annotations' file (JSONL
                        or JSONL.gz). If omitted, data are read from STDIN.
  -a, --genewise_annotations PATH_GENEWISE
                        Path to the 'genewise_phenotype_annotations' file
                        (JSONL or JSONL.gz). Required when using
                        '-g/--genewise' to determine genes that were measured.
```


## tsumugi_score

### Tool Description
Filter genes based on the similarity score per KO or shared between KO pairs.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/akikuno/TSUMUGI-dev
- **Package**: https://anaconda.org/channels/bioconda/packages/tsumugi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tsumugi score [-h] [--min MIN] [--max MAX] [--in PATH_PAIRWISE]

Filter genes based on the similarity score per KO or shared between KO pairs.

options:
  -h, --help          show this help message and exit
  --min MIN           Minimum number threshold
  --max MAX           Maximum number threshold
  --in PATH_PAIRWISE  Path to 'pairwise_similarity_annotations' file (JSONL or
                      JSONL.gz). If omitted, data are read from STDIN.
```


## tsumugi_genes

### Tool Description
Filter annotations based on gene symbols or gene pairs.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/akikuno/TSUMUGI-dev
- **Package**: https://anaconda.org/channels/bioconda/packages/tsumugi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tsumugi genes [-h] (-k GENE_SYMBOL | -d GENE_SYMBOL) [-g | -p]
                     [--in PATH_PAIRWISE]

options:
  -h, --help            show this help message and exit
  -k, --keep GENE_SYMBOL
                        Keep ONLY annotations with gene symbols or gene pairs listed in a text file
  -d, --drop GENE_SYMBOL
                        Drop annotations with gene symbols or gene pairs listed in a text file
  -g, --genewise        Filter by user-provided gene symbols
  -p, --pairwise        Filter by user-provided  gene pairs
  --in PATH_PAIRWISE    Path to 'pairwise_similarity_annotations' file (JSONL or JSONL.gz).
                        If omitted, data are read from STDIN.
```


## tsumugi_life-stage

### Tool Description
Keep or drop annotations based on life stage.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/akikuno/TSUMUGI-dev
- **Package**: https://anaconda.org/channels/bioconda/packages/tsumugi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tsumugi life-stage [-h] (-k LIFE_STAGE | -d LIFE_STAGE)
                          [--in PATH_PAIRWISE]

options:
  -h, --help            show this help message and exit
  -k, --keep LIFE_STAGE
                        Keep ONLY annotations with the specified life stage
  -d, --drop LIFE_STAGE
                        Drop annotations with the specified life stage
  --in PATH_PAIRWISE    Path to 'pairwise_similarity_annotations' file (JSONL or JSONL.gz).
                        If omitted, data are read from STDIN.
```


## tsumugi_sex

### Tool Description
Keep or drop annotations based on sexual dimorphism.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/akikuno/TSUMUGI-dev
- **Package**: https://anaconda.org/channels/bioconda/packages/tsumugi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tsumugi sex [-h] (-k SEX | -d SEX) [--in PATH_PAIRWISE]

options:
  -h, --help          show this help message and exit
  -k, --keep SEX      Keep ONLY annotations with the specified sexual dimorphism
  -d, --drop SEX      Drop annotations with the specified sexual dimorphism
  --in PATH_PAIRWISE  Path to 'pairwise_similarity_annotations' file (JSONL or JSONL.gz).
                      If omitted, data are read from STDIN.
```


## tsumugi_zygosity

### Tool Description
Keep or drop annotations based on zygosity.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/akikuno/TSUMUGI-dev
- **Package**: https://anaconda.org/channels/bioconda/packages/tsumugi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tsumugi zygosity [-h] (-k ZYGOSITY | -d ZYGOSITY) [--in PATH_PAIRWISE]

options:
  -h, --help           show this help message and exit
  -k, --keep ZYGOSITY  Keep ONLY annotations with the specified zygosity
  -d, --drop ZYGOSITY  Drop annotations with the specified zygosity
  --in PATH_PAIRWISE   Path to 'pairwise_similarity_annotations' file (JSONL or JSONL.gz).
                       If omitted, data are read from STDIN.
```


## tsumugi_build-graphml

### Tool Description
Builds a graphml file from pairwise and genewise similarity annotations.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/akikuno/TSUMUGI-dev
- **Package**: https://anaconda.org/channels/bioconda/packages/tsumugi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tsumugi build-graphml [-h] [--in PATH_PAIRWISE] -a PATH_GENEWISE

options:
  -h, --help            show this help message and exit
  --in PATH_PAIRWISE    Path to 'pairwise_similarity_annotations' file (JSONL or JSONL.gz).
                        If omitted, data are read from STDIN.
  -a, --genewise_annotations PATH_GENEWISE
                        Path to the 'genewise_phenotype_annotations' file (JSONL or JSONL.gz).
```


## tsumugi_build-webapp

### Tool Description
Builds a web application for visualizing Tsumugi results.

### Metadata
- **Docker Image**: quay.io/biocontainers/tsumugi:1.0.2--pyhdfd78af_0
- **Homepage**: https://github.com/akikuno/TSUMUGI-dev
- **Package**: https://anaconda.org/channels/bioconda/packages/tsumugi/overview
- **Validation**: PASS

### Original Help Text
```text
usage: tsumugi build-webapp [-h] [--in PATH_PAIRWISE] -a PATH_GENEWISE
                            -o OUTPUT_DIR

options:
  -h, --help            show this help message and exit
  --in PATH_PAIRWISE    Path to 'pairwise_similarity_annotations' file (JSONL or JSONL.gz).
                        If omitted, data are read from STDIN.
  -a, --genewise_annotations PATH_GENEWISE
                        Path to the 'genewise_phenotype_annotations' file (JSONL or JSONL.gz).
  -o, --out OUTPUT_DIR
```

