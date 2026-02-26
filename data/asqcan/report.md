# asqcan CWL Generation Report

## asqcan

### Tool Description
A combined pipeline for bacterial genome ASsembly, Quality Control, and ANnotation.

### Metadata
- **Docker Image**: quay.io/biocontainers/asqcan:0.4--pyh7cba7a3_0
- **Homepage**: https://github.com/bogemad/asqcan
- **Package**: https://anaconda.org/channels/bioconda/packages/asqcan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/asqcan/overview
- **Total Downloads**: 11.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/bogemad/asqcan
- **Stars**: N/A
### Original Help Text
```text
usage: asqcan [-h] -q READS_DIR -o OUTDIR [-s {blastn,diamond}] [-b DB] [-i]
              [-t THREADS] [-m MEM] [-f] [--version] [-v]

asqcan - A combined pipeline for bacterial genome ASsembly, Quality Control,
and ANnotation.

required arguments:
  -q READS_DIR, --fastq-dir READS_DIR
                        Path to a directory with your interleaved fastq files.
  -o OUTDIR, --output-directory OUTDIR
                        Path to the output directory. A directory will be
                        created if one does not exist.

options:
  -h, --help            show this help message and exit
  -s {blastn,diamond}, --searcher {blastn,diamond}
                        Search algorithm to use. Options [blastn, diamond]
  -b DB, --search_database DB
                        Path to the local search database. This pipeline does
                        not require you to have a local copy of a search
                        database but without it you will not be able to use
                        similarity data for blobtools. Similarity data adds
                        significantly to the blobplot and blobtools table
                        outputs of this pipeline. See https://blast.ncbi.nlm.n
                        ih.gov/Blast.cgi?CMD=Web&PAGE_TYPE=BlastDocs&DOC_TYPE=
                        Download to install a local database.
  -i, --ion-torrent     Reads are sourced from the Ion Torrent platform. Don't
                        include this if your reads are Illumina-sourced.
  -t THREADS, --threads THREADS
                        Number of threads to use for multiprocessing.
  -m MEM, --max_memory MEM
                        Maximum amount of RAM to assign to the pipeline in GB
                        (Just the number).
  -f, --force           Overwrite files in the output directories.
  --version             show program's version number and exit
  -v, --verbose         Increase verbosity on command line output (n.b.
                        verbose output is always saved to asqcan.log in the
                        output directory).
```

