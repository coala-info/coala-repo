# pore-c CWL Generation Report

## pore-c_pore_c

### Tool Description
A suite of tools designed to analyse Oxford Nanopore reads with multiway
  chromatin contacts.

### Metadata
- **Docker Image**: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
- **Homepage**: https://github.com/nanoporetech/pore-c
- **Package**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pore-c/overview
- **Total Downloads**: 5.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/nanoporetech/pore-c
- **Stars**: N/A
### Original Help Text
```text
Usage: pore_c [OPTIONS] COMMAND [ARGS]...

  Pore-C tools

  A suite of tools designed to analyse Oxford Nanopore reads with multiway
  chromatin contacts.

Options:
  -v, --verbosity                 Increase level of logging information, eg.
                                  -vvv

  --quiet                         Turn off all logging  [default: False]
  --dask-num-workers INTEGER      Number of dask workers
  --dask-use-threads              Use threads instead of processes
  --dask-threads-per-worker INTEGER
                                  Number of threads per worker
  --dask-scheduler-port INTEGER   The port to use for the dask scheduler, set
                                  to 0 to use a random port

  --dask-dashboard-port INTEGER   The port to use for the dask dashboard, set
                                  to 0 to use a random port

  --dask-disable-dashboard        Disable the dask dashboard
  --help                          Show this message and exit.

Commands:
  refgenome   Pre-process reference genome files.
  reads       Analyse raw reads
  alignments  Analyse aligned pore_c reads
  contacts    Work the the contacts table
  utils       Misc tools
```

