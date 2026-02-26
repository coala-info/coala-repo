# hca-matrix-downloader CWL Generation Report

## hca-matrix-downloader

### Tool Description
Download data via HCA DCP FTP. Requires -p input. Files are downloaded into current working directory.

### Metadata
- **Docker Image**: quay.io/biocontainers/hca-matrix-downloader:0.0.4--py_0
- **Homepage**: https://github.com/ebi-gene-expression-group/hca-matrix-downloader
- **Package**: https://anaconda.org/channels/bioconda/packages/hca-matrix-downloader/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hca-matrix-downloader/overview
- **Total Downloads**: 8.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ebi-gene-expression-group/hca-matrix-downloader
- **Stars**: N/A
### Original Help Text
```text
usage: Download data via HCA DCP FTP. Requires -p input. Files are downloaded into current working directory.
       [-h] -p PROJECT [-f {loom,mtx}] [-o OUTPREFIX] [-s SPECIES]

optional arguments:
  -h, --help            show this help message and exit
  -p PROJECT, --project PROJECT
                        The project's Project Title, Project short name or
                        link-derived ID, obtained from the HCA DCP, wrapped in
                        quotes.
  -f {loom,mtx}, --format {loom,mtx}
                        Format to download matrix in: loom or mtx (Matrix
                        Market). Defaults to loom.
  -o OUTPREFIX, --outprefix OUTPREFIX
                        Output prefix to replace project uuid in filename of
                        downloaded matrix. Leave as project uuid if not
                        specified.
  -s SPECIES, --species SPECIES
                        The species to use, when a project has more than one.
```

