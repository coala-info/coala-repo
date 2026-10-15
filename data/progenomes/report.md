# progenomes CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| progenomes_download_datasets | PASS | Downloaded the highly important strains table (820 genome IDs). |
| progenomes_download_genomes | Not completed | downloads the full representative genome set (many GB); not run |
| progenomes_view | PASS | Needs network access (NetworkAccess requirement added); listed 820 highly important strains. |

## progenomes_view

### Tool Description
View datasets within the Progenomes database.

### Metadata
- **Docker Image**: quay.io/biocontainers/progenomes:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/progenomes-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/progenomes/overview
- **Validation**: PASS

### Original Help Text
```text
usage: progenomes view [-h]
                       {highly-important-strains,excluded-genomes,ani-representatives,ani-clustering,functional-annotations}

positional arguments:
  {highly-important-strains,excluded-genomes,ani-representatives,ani-clustering,functional-annotations}
                        Dataset to view. Available options: Highly important
                        strains, Excluded genomes, ANI representatives, ANI
                        clustering, Functional annotations for representative
                        genomes.

options:
  -h, --help            show this help message and exit
```


## progenomes_download_datasets

### Tool Description
Download a table dataset from the Progenomes database

### Metadata
- **Docker Image**: quay.io/biocontainers/progenomes:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/progenomes-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/progenomes/overview
- **Validation**: PASS

### Original Help Text
```text
usage: progenomes download datasets [-h]
                                    {highly-important-strains,excluded-genomes,ani-representatives,ani-clustering,functional-annotations}

positional arguments:
  {highly-important-strains,excluded-genomes,ani-representatives,ani-clustering,functional-annotations}
                        Dataset to download. Available options: Highly
                        important strains, Excluded genomes, ANI
                        representatives, ANI clustering, Functional
                        annotations for representative genomes.

options:
  -h, --help            show this help message and exit
```

## progenomes_download_genomes

### Tool Description
Download the representative genome set from the Progenomes database

### Metadata
- **Docker Image**: quay.io/biocontainers/progenomes:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/progenomes-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/progenomes/overview
- **Validation**: PASS

### Original Help Text
```text
usage: progenomes download genomes [-h] [-c] [-g] [-p] [-a]
                                   {representative-genomes}

positional arguments:
  {representative-genomes}
                        Representative genome set to download. Available
                        options: Representative genomes.

options:
  -h, --help            show this help message and exit
  -c, --contigs         Contigs
  -g, --genes           Genes
  -p, --proteins        Proteins
  -a, --all             All
```

## Metadata
- **Skill**: generated
