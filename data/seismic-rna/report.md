# seismic-rna CWL Generation Report

## seismic-rna_seismic

### Tool Description
Command line interface of SEISMIC-RNA.

### Metadata
- **Docker Image**: quay.io/biocontainers/seismic-rna:0.24.4--py311haab0aaa_0
- **Homepage**: https://github.com/rouskinlab/seismic-rna
- **Package**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/seismic-rna/overview
- **Total Downloads**: 8.2K
- **Last updated**: 2026-01-30
- **GitHub**: https://github.com/rouskinlab/seismic-rna
- **Stars**: N/A
### Original Help Text
```text
Usage: seismic [OPTIONS] COMMAND [ARGS]...

  Command line interface of SEISMIC-RNA.

Options:
  -v, --verbose                   Log more messages (-v, -vv, -vvv, -vvvv) on
                                  stderr  [default: 0]
  -q, --quiet                     Log fewer messages (-q, -qq, -qqq, -qqqq) on
                                  stderr  [default: 0]
  --log FILE                      Log all messages to this file ('' to
                                  disable)  [default: /log/seismic-
                                  rna_2026-02-24_15-33-12.log]
  --log-color / --log-plain       Log messages with or without color codes on
                                  stderr  [default: log-color]
  --exit-on-error / --log-on-error
                                  If an error occurs, whether to log a message
                                  or exit SEISMIC-RNA  [default: log-on-error]
  --version                       Show the version and exit.
  --help                          Show this message and exit.

Commands:
  align      Trim FASTQ files and align them to reference sequences.
  biorxiv    Open the preprint for SEISMIC-RNA in bioRxiv.
  cleanfa    Clean the names and sequences in FASTA files.
  cluster    Infer structure ensembles by clustering reads' mutations.
  conda      Open SEISMIC-RNA on Anaconda's website.
  ct2db      Convert connectivity table (CT) to dot-bracket (DB) files.
  datapath   Guess the DATAPATH for RNAstructure.
  db2ct      Convert dot-bracket (DB) to connectivity table (CT) files.
  demult     Split multiplexed FASTQ files by their barcodes.
  docs       Open the documentation for SEISMIC-RNA.
  draw       Draw RNA structures with reactivities using RNArtistCore.
  ensembles  Infer independent structure ensembles along an entire RNA.
  export     Export each sample to SEISMICgraph (https://seismicrna.org).
  fold       Predict RNA secondary structures using mutation rates.
  github     Open SEISMIC-RNA's source code on GitHub.
  graph      Graph and compare data from tables and/or structures.
  join       Merge regions (horizontally) from the Mask or Cluster step.
  list       List positions to mask.
  mask       Define mutations and regions to filter reads and positions.
  migrate    Migrate output directories from v0.23 to v0.24
  pool       Merge samples (vertically) from the Relate step.
  pypi       Open SEISMIC-RNA on the Python Packaging Index.
  relate     Compute relationships between references and aligned reads.
  renumct    Renumber connectivity table (CT) files given a 5' position.
  sim        Simulate sequences, structures, and samples.
  splitbam   Split a BAM file into one file for each reference.
  table      Tabulate counts of relationships per read and position.
  test       Run all unit tests.
  wf         Run the entire workflow.
```

