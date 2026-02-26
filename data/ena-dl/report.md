# ena-dl CWL Generation Report

## ena-dl

### Tool Description
Download FASTQs from ENA

### Metadata
- **Docker Image**: quay.io/biocontainers/ena-dl:1.0.0--1
- **Homepage**: https://github.com/rpetit3/ena-dl
- **Package**: https://anaconda.org/channels/bioconda/packages/ena-dl/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ena-dl/overview
- **Total Downloads**: 3.6K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/rpetit3/ena-dl
- **Stars**: N/A
### Original Help Text
```text
usage: ena-dl [-h] [--aspera STRING] [--aspera_key STRING]
              [--aspera_speed STRING] [--is_study] [--is_experiment]
              [--is_run] [--group_by_experiment] [--group_by_sample]
              [--outdir OUTPUT_DIR] [--max_retry INT] [--ftp_only] [--silent]
              [--debug] [--version]
              ACCESSION

ena-dl (v1.0.0) - Download FASTQs from ENA

optional arguments:
  -h, --help            show this help message and exit

Required Options:

  ACCESSION             ENA accession to query. (Study, Experiment, or Run
                        accession)

Aspera Connect Options:
  --aspera STRING       Path to the Aspera Connect tool "ascp" (Default:
                        "which ascp")
  --aspera_key STRING   Path to Aspera Connect private key, if not given,
                        guess based on ascp path
  --aspera_speed STRING
                        Speed at which Aspera Connect will download. (Default:
                        100M)

Query Related Options:
  --is_study            Query is a Study.
  --is_experiment       Query is an Experiment.
  --is_run              Query is a Run.
  --group_by_experiment
                        Group Runs by experiment accession.
  --group_by_sample     Group Runs by sample accession.

Helpful Options:
  --outdir OUTPUT_DIR   Directory to output downloads to. (Default: ./)
  --max_retry INT       Maximum times to retry downloads (Default: 10)
  --ftp_only            FTP only downloads.
  --silent              Only critical errors will be printed.
  --debug               Skip downloads, print what will be downloaded.
  --version             show program's version number and exit
```

