# pyensembl CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| pyensembl_delete-all-files | PASS |  |
| pyensembl_delete-index-files | Failed | tool bug: delete_index_files calls the string property local_db_path as a function and crashes with TypeError. |
| pyensembl_install | Failed | image problem: the yeast Ensembl 110 files download, but indexing crashes because datacache uses numpy.typeDict, which the image's numpy 1.26 lacks. |
| pyensembl_list | PASS |  |

## pyensembl_install

### Tool Description
Manipulate pyensembl's local cache.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyensembl:2.3.13--pyh7cba7a3_0
- **Homepage**: https://github.com/openvax/pyensembl
- **Package**: https://anaconda.org/channels/bioconda/packages/pyensembl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyensembl/overview
- **Total Downloads**: 68.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/openvax/pyensembl
- **Stars**: N/A
### Original Help Text
```text
usage: 
Manipulate pyensembl's local cache.

    pyensembl {install, delete, delete-sequence-cache} [--release XXX --species human...]

To install particular Ensembl human release(s):
    pyensembl install --release 75 77

To install particular Ensembl mouse release(s):
    pyensembl install --release 75 77 --species mouse

To delete all downloaded and cached data for a particular Ensembl release:
    pyensembl delete-all-files --release 75 --species human

To delete only cached data related to transcript and protein sequences:
    pyensembl delete-index-files --release 75

To list all installed genomes:
    pyensembl list

To install a genome from source files:
    pyensembl install  --reference-name "GRCh38"  --gtf URL_OR_PATH  --transcript-fasta URL_OR_PATH  --protein-fasta URL_OR_PATH

positional arguments:
  {install,delete-all-files,delete-index-files,list}
                        "install" will download and index any data that is not
                        currently downloaded or indexed. "delete-all-files"
                        will delete all data associated with a genome
                        annotation. "delete-index-files" deletes all files
                        other than the original GTF and FASTA files for a
                        genome. "list" will show you all installed Ensembl
                        genomes.

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --overwrite           Force download and indexing even if files already
                        exist locally
```


## pyensembl_delete-all-files

### Tool Description
Manipulate pyensembl's local cache.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyensembl:2.3.13--pyh7cba7a3_0
- **Homepage**: https://github.com/openvax/pyensembl
- **Package**: https://anaconda.org/channels/bioconda/packages/pyensembl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 
Manipulate pyensembl's local cache.

    pyensembl {install, delete, delete-sequence-cache} [--release XXX --species human...]

To install particular Ensembl human release(s):
    pyensembl install --release 75 77

To install particular Ensembl mouse release(s):
    pyensembl install --release 75 77 --species mouse

To delete all downloaded and cached data for a particular Ensembl release:
    pyensembl delete-all-files --release 75 --species human

To delete only cached data related to transcript and protein sequences:
    pyensembl delete-index-files --release 75

To list all installed genomes:
    pyensembl list

To install a genome from source files:
    pyensembl install  --reference-name "GRCh38"  --gtf URL_OR_PATH  --transcript-fasta URL_OR_PATH  --protein-fasta URL_OR_PATH

positional arguments:
  {install,delete-all-files,delete-index-files,list}
                        "install" will download and index any data that is not
                        currently downloaded or indexed. "delete-all-files"
                        will delete all data associated with a genome
                        annotation. "delete-index-files" deletes all files
                        other than the original GTF and FASTA files for a
                        genome. "list" will show you all installed Ensembl
                        genomes.

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --overwrite           Force download and indexing even if files already
                        exist locally
```


## pyensembl_delete-index-files

### Tool Description
Deletes all files other than the original GTF and FASTA files for a genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyensembl:2.3.13--pyh7cba7a3_0
- **Homepage**: https://github.com/openvax/pyensembl
- **Package**: https://anaconda.org/channels/bioconda/packages/pyensembl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 
Manipulate pyensembl's local cache.

    pyensembl {install, delete, delete-sequence-cache} [--release XXX --species human...]

To install particular Ensembl human release(s):
    pyensembl install --release 75 77

To install particular Ensembl mouse release(s):
    pyensembl install --release 75 77 --species mouse

To delete all downloaded and cached data for a particular Ensembl release:
    pyensembl delete-all-files --release 75 --species human

To delete only cached data related to transcript and protein sequences:
    pyensembl delete-index-files --release 75

To list all installed genomes:
    pyensembl list

To install a genome from source files:
    pyensembl install  --reference-name "GRCh38"  --gtf URL_OR_PATH  --transcript-fasta URL_OR_PATH  --protein-fasta URL_OR_PATH

positional arguments:
  {install,delete-all-files,delete-index-files,list}
                        "install" will download and index any data that is not
                        currently downloaded or indexed. "delete-all-files"
                        will delete all data associated with a genome
                        annotation. "delete-index-files" deletes all files
                        other than the original GTF and FASTA files for a
                        genome. "list" will show you all installed Ensembl
                        genomes.

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --overwrite           Force download and indexing even if files already
                        exist locally
```


## pyensembl_list

### Tool Description
Manipulate pyensembl's local cache.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyensembl:2.3.13--pyh7cba7a3_0
- **Homepage**: https://github.com/openvax/pyensembl
- **Package**: https://anaconda.org/channels/bioconda/packages/pyensembl/overview
- **Validation**: PASS

### Original Help Text
```text
usage: 
Manipulate pyensembl's local cache.

    pyensembl {install, delete, delete-sequence-cache} [--release XXX --species human...]

To install particular Ensembl human release(s):
    pyensembl install --release 75 77

To install particular Ensembl mouse release(s):
    pyensembl install --release 75 77 --species mouse

To delete all downloaded and cached data for a particular Ensembl release:
    pyensembl delete-all-files --release 75 --species human

To delete only cached data related to transcript and protein sequences:
    pyensembl delete-index-files --release 75

To list all installed genomes:
    pyensembl list

To install a genome from source files:
    pyensembl install  --reference-name "GRCh38"  --gtf URL_OR_PATH  --transcript-fasta URL_OR_PATH  --protein-fasta URL_OR_PATH

positional arguments:
  {install,delete-all-files,delete-index-files,list}
                        "install" will download and index any data that is not
                        currently downloaded or indexed. "delete-all-files"
                        will delete all data associated with a genome
                        annotation. "delete-index-files" deletes all files
                        other than the original GTF and FASTA files for a
                        genome. "list" will show you all installed Ensembl
                        genomes.

options:
  -h, --help            show this help message and exit
  --version             show program's version number and exit
  --overwrite           Force download and indexing even if files already
                        exist locally
```


## Metadata
- **Skill**: generated
