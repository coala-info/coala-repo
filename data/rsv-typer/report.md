# rsv-typer CWL Generation Report

## rsv-typer

### Tool Description
A tool for typing RSV sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/rsv-typer:0.5.0--pyh7e72e81_0
- **Homepage**: https://github.com/DiltheyLab/RSVTyper
- **Package**: https://anaconda.org/channels/bioconda/packages/rsv-typer/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/rsv-typer/overview
- **Total Downloads**: 3.4K
- **Last updated**: 2025-08-09
- **GitHub**: https://github.com/DiltheyLab/RSVTyper
- **Stars**: N/A
### Original Help Text
```text
usage: rsv-typer [-h] -i INPUT -s SAMPLE -o OUTPUTDIR -m MEDAKAMODEL
                 [-a AMPLICONLENGTH] [-p SCHEMEDIR] [-V SCHEMEVERSION]
                 [-r REFDIR] [-n NEXTCLADEOUTPUT] [-t THREADS]

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Path to basecalled, demultiplexed fastq-files. It
                        should end with the barcode directory (e.g.
                        barcode15/)
  -s SAMPLE, --sample SAMPLE
                        Name of the sample
  -o OUTPUTDIR, --outputDir OUTPUTDIR
                        Output directory
  -m MEDAKAMODEL, --medakaModel MEDAKAMODEL
                        Medaka model that should be used for the artic
                        pipeline (depends on basecaller used)
  -a AMPLICONLENGTH, --ampliconLength AMPLICONLENGTH
                        Minimum and maximum length of your amplicons comma
                        separated (e.g. 350,900). Add 200 nt to your maximum
                        length.
  -p SCHEMEDIR, --schemeDir SCHEMEDIR
                        Path to primal scheme if the location of it was
                        changed
  -V SCHEMEVERSION, --schemeVersion SCHEMEVERSION
                        Name of your primer scheme version
  -r REFDIR, --refDir REFDIR
                        Path to directory containing the references if the
                        location was changed
  -n NEXTCLADEOUTPUT, --nextcladeOutput NEXTCLADEOUTPUT
                        Output file format of the nextclade results (tsv, csv,
                        json, ndjson, all). Default: tsv
  -t THREADS, --threads THREADS
                        Number of threads
```

