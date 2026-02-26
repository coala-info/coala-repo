# sylph-tax CWL Generation Report

## sylph-tax_taxprof

### Tool Description
Generates a taxonomy profile from SYLPH result files.

### Metadata
- **Docker Image**: quay.io/biocontainers/sylph-tax:1.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/bluenote-1577/sylph-tax
- **Package**: https://anaconda.org/channels/bioconda/packages/sylph-tax/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sylph-tax/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-12-18
- **GitHub**: https://github.com/bluenote-1577/sylph-tax
- **Stars**: N/A
### Original Help Text
```text
usage: sylph-tax taxprof [-h] [-o STRING] -t FILE [FILE ...] [-a] [-f]
                         [--pavian] [--overwrite]
                         SYLPH-FILE [SYLPH-FILE ...]

positional arguments:
  SYLPH-FILE            sylph result files (TSV)

options:
  -h, --help            show this help message and exit
  -o, --output-prefix STRING
                        Append this prefix to the outputs. Output files will
                        be 'prefix + Sample_file_column + .sylphmpa'
  -t, --taxonomy-metadata FILE [FILE ...]
                        Taxonomy metadata inputs. If multiple are provided,
                        they will be merged. Provided taxonomies:
                        [FungiRefSeq-latest, FungiRefSeq-2024-07-25,
                        GTDB_r214, GTDB_r220, GTDB_r226, IMGVR_4.1,
                        UHGV_default, UHGV_ictv, OceanDNA, SoilSMAG,
                        TaraEukaryoticSMAG, GlobDB_r226]. Custom metadata
                        files (.tsv) can be used as well; see online manual.
  -a, --annotate-virus-hosts
                        Add additional column(s) by integrating viral-host
                        information available (currently available for
                        IMGVR4.1, UHGV taxonomies)
  -f, --add-folder-information
                        Include directory/folder path information in the
                        output files. This is needed if your samples have the
                        same read name but different directory structures.
  --pavian              Make a pavian-compatible taxonomy file for
                        visualization. Not recommended except for use with
                        pavian.
  --overwrite           Force overwriting of output files.
```


## sylph-tax_merge

### Tool Description
Merge multiple sylph-tax taxonomy files into a single TSV table.

### Metadata
- **Docker Image**: quay.io/biocontainers/sylph-tax:1.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/bluenote-1577/sylph-tax
- **Package**: https://anaconda.org/channels/bioconda/packages/sylph-tax/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sylph-tax merge [-h] [-o OUTPUT]
                       --column {relative_abundance,sequence_abundance,ANI,Coverage}
                       files [files ...]

positional arguments:
  files                 Paths to the *.sylphmpa files output by sylph-tax
                        taxonomy

options:
  -h, --help            show this help message and exit
  -o, --output OUTPUT   Name of the tsv table to output
  --column {relative_abundance,sequence_abundance,ANI,Coverage}
                        The data type to output
```


## sylph-tax_download

### Tool Description
Download taxonomy metadata

### Metadata
- **Docker Image**: quay.io/biocontainers/sylph-tax:1.8.0--pyhdfd78af_0
- **Homepage**: https://github.com/bluenote-1577/sylph-tax
- **Package**: https://anaconda.org/channels/bioconda/packages/sylph-tax/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sylph-tax download [-h] [--download-to DOWNLOAD_TO]

options:
  -h, --help            show this help message and exit
  --download-to DOWNLOAD_TO
                        Download taxonomy metadata to this directory (must
                        exist, e.g. my/folder/). A config file is written to
                        $HOME or $SYLPH_TAXONOMY_CONFIG.
```

