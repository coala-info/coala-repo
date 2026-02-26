# cirtap CWL Generation Report

## cirtap_best

### Tool Description
Select best genomes based on stats retrieved from genome_summary

### Metadata
- **Docker Image**: quay.io/biocontainers/cirtap:0.3.1--pyh5e36f6f_0
- **Homepage**: https://github.com/MGXlab/cirtap/
- **Package**: https://anaconda.org/channels/bioconda/packages/cirtap/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cirtap/overview
- **Total Downloads**: 8.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/MGXlab/cirtap
- **Stars**: N/A
### Original Help Text
```text
Usage: cirtap best [OPTIONS] OUTPUT_PATH

  Select best genomes based on stats retrieved from genome_summary

  Results are written in the provided output_path and include tables
  containing genome ids with their stats and lineages attached

Options:
  -i, --index-path PATH  Path to the index file  [required]
  -d, --db-dir PATH      Path to the local mirror. Must contain a
                         `RELEASE_NOTES` directory and a `genomes` directory
                         [required]
  --thresh INTEGER       Integer threshold for including a genome based on
                         completeness and contamination stats. This is useed
                         as completeness - 5*contamination > thresh  [default:
                         70]
  --ncbi-db PATH         Path to the taxa.sqlite created by ete3  [default:
                         /root/.etetoolkit/taxa.sqlite]
  --loglevel TEXT        Define loglevel  [default: INFO]
  --logfile TEXT         Write logging information in this file
  -h, --help             Show this message and exit.
```


## cirtap_collect

### Tool Description
Create sequence sets based on the installed files

### Metadata
- **Docker Image**: quay.io/biocontainers/cirtap:0.3.1--pyh5e36f6f_0
- **Homepage**: https://github.com/MGXlab/cirtap/
- **Package**: https://anaconda.org/channels/bioconda/packages/cirtap/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cirtap collect [OPTIONS] GENOMES_DIR OUTPUT_PATH

  Create sequence sets based on the installed files

  Only 16S rRNA seqs and proteins are supported for now.

  **ATTENTION** Due to the way things are implemented any jobs number you
  supply will be multiplied by 4.

Options:
  -i, --index-path PATH           [required]
  -t, --target-set [SSU|proteins]
                                  Sequence set to create. One of `SSU` (based
                                  on .PATRIC.frn) and `proteins` (based on
                                  .PATRIC.faa)
  -j, --jobs INTEGER              Parallel jobs to run  [default: 1]
  --cleanup                       Remove all intermediate files produced
  --loglevel TEXT                 Define loglevel  [default: INFO]
  --logfile TEXT                  Write logging information in this file
  -h, --help                      Show this message and exit.
```


## cirtap_index

### Tool Description
Create an index of contents for all directories

  This can be useful for generating valid paths before gathering inputs. The
  output_index is a tab-separated file with each column representing the files
  that are expected to be found for a genome that has full information
  available from both PATRIC and RefSeq. If any of the files is missing the
  value is 0.

### Metadata
- **Docker Image**: quay.io/biocontainers/cirtap:0.3.1--pyh5e36f6f_0
- **Homepage**: https://github.com/MGXlab/cirtap/
- **Package**: https://anaconda.org/channels/bioconda/packages/cirtap/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cirtap index [OPTIONS] GENOMES_DIR OUTPUT_INDEX

  Create an index of contents for all directories

  This can be useful for generating valid paths before gathering inputs. The
  output_index is a tab-separated file with each column representing the files
  that are expected to be found for a genome that has full information
  available from both PATRIC and RefSeq. If any of the files is missing the
  value is 0.

  genomes_dir: The location where all data is stored

  output_index:  The files to write all the info in

Options:
  --loglevel TEXT     Define loglevel  [default: INFO]
  --logfile TEXT      Write logging information in this file
  -j, --jobs INTEGER  Number of parallel reads to execute. Speeds things up
                      when iterating over all the data dirs  [default: 1]
  -h, --help          Show this message and exit.
```


## cirtap_mirror

### Tool Description
Mirror all data from ftp.patricbrc.org in the specified DB_DIR

### Metadata
- **Docker Image**: quay.io/biocontainers/cirtap:0.3.1--pyh5e36f6f_0
- **Homepage**: https://github.com/MGXlab/cirtap/
- **Package**: https://anaconda.org/channels/bioconda/packages/cirtap/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cirtap mirror [OPTIONS] DB_DIR

  Mirror all data from ftp.patricbrc.org in the specified DB_DIR

Options:
  --cache-dir PATH          Directory where cirtap will store some info for
                            its execution. Subsequent executions rely on it so
                            be careful when you delete
  -j, --jobs INTEGER        Number of parallel processes to start for
                            downloading  [default: 1]
  --skip-release-check      Skip checking for RELEASE_NOTES based updates
                            [default: False]
  --skip-processed-genomes  Skip checks for already processed genomes as found
                            in the cache.  [default: False]
  --force-check             Force update the genomes directory regardless of
                            RELEASE_NOTES outcome  [default: False]
  -r, --resume              Use this to set both --skip-release-check and
                            --skip-processed-genomes on. Useful for resuming a
                            failed run  [default: False]
  --loglevel TEXT           Define loglevel  [default: INFO]
  --archive-notes           Create an tar.gz archive of the RELEASE_NOTES
                            files in the DB_DIR  [default: False]
  --notify TEXT             Comma (,) separated list of emails provided as a
                            string. E.g.
                            'user1@mail.com,user2@anothermail.com'
  --progress                (Experimental) Print a progress bar when
                            downloading genomes. This option cannot be set
                            with `--loglevel debug`. If they are both
                            supplied, progress will not be shown and the more
                            descriptive debugging messages will be printed to
                            stderr instead  [default: False]
  --logfile TEXT            Write logging information in this file
  -h, --help                Show this message and exit.
```


## cirtap_pack

### Tool Description
Create a gzipped tar archive from a list of genome ids in a file

### Metadata
- **Docker Image**: quay.io/biocontainers/cirtap:0.3.1--pyh5e36f6f_0
- **Homepage**: https://github.com/MGXlab/cirtap/
- **Package**: https://anaconda.org/channels/bioconda/packages/cirtap/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: cirtap pack [OPTIONS]

  Create a gzipped tar archive from a list of genome ids in a file

  For now the output specified is a tar.gz file, even if you don't name it as
  such.

Options:
  -g, --genomes-dir PATH  Path to the genomes directory containing all data
                          [required]
  -i, --input-list PATH   Single column file containing one genome id per line
                          [required]
  -o, --output PATH       Output gzipped file to write. For now only gzip
                          compression is supported  [required]
  --loglevel TEXT         Define loglevel  [default: INFO]
  --logfile TEXT          Write logging information in this file
  -h, --help              Show this message and exit.
```

