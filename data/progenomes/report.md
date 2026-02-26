# progenomes CWL Generation Report

## progenomes_download

### Tool Description
Download datasets from Progenomes

### Metadata
- **Docker Image**: quay.io/biocontainers/progenomes:0.3.0--pyhdfd78af_0
- **Homepage**: https://github.com/BigDataBiology/progenomes-cli
- **Package**: https://anaconda.org/channels/bioconda/packages/progenomes/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/progenomes/overview
- **Total Downloads**: 102
- **Last updated**: 2025-12-01
- **GitHub**: https://github.com/BigDataBiology/progenomes-cli
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/progenomes", line 10, in <module>
    sys.exit(main())
             ~~~~^^
  File "/usr/local/lib/python3.14/site-packages/progenomes/cli/progenomes.py", line 101, in main
    download_dataset(args.target)
                     ^^^^^^^^^^^
AttributeError: 'Namespace' object has no attribute 'target'
```


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

