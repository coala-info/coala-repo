# coidb CWL Generation Report

## coidb

### Tool Description
Builds a DAG of jobs for processing biological data.

### Metadata
- **Docker Image**: quay.io/biocontainers/coidb:0.4.8--pyhdfd78af_0
- **Homepage**: https://github.com/johnne/coidb
- **Package**: https://anaconda.org/channels/bioconda/packages/coidb/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/coidb/overview
- **Total Downloads**: 14.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/johnne/coidb
- **Stars**: N/A
### Original Help Text
```text
Building DAG of jobs...
Using shell: /bin/bash
Provided cores: 4
Rules claiming more threads will be scaled down.
Singularity containers: ignored
Job stats:
job                    count    min threads    max threads
-------------------  -------  -------------  -------------
clean                      1              1              1
cluster                    1              4              4
coidb                      1              1              1
download_zipfile           2              1              1
extract_zipfile            3              1              1
filter_data                1              1              1
format_dada2               1              1              1
format_sintax              1              1              1
remove_non_standard        1              1              1
total                     12              1              4

Select jobs to execute...

[Tue Feb 24 21:52:46 2026]
rule download_zipfile:
    output: bold.zip
    log: logs/download.bold.zip.log
    jobid: 7
    reason: Missing output files: bold.zip
    wildcards: zipfile=bold.zip
    resources: tmpdir=/tmp


[Tue Feb 24 21:52:46 2026]
rule download_zipfile:
    output: backbone.zip
    log: logs/download.backbone.zip.log
    jobid: 10
    reason: Missing output files: backbone.zip
    wildcards: zipfile=backbone.zip
    resources: tmpdir=/tmp

[Tue Feb 24 21:52:46 2026]
Error in rule download_zipfile:
    jobid: 7
    output: bold.zip
    log: logs/download.bold.zip.log (check log file(s) for error details)
    shell:
        
        curl -L -o $TMPDIR/bold.zip https://hosted-datasets.gbif.org/ibol/ibol.zip > logs/download.bold.zip.log 2>&1
        mv $TMPDIR/bold.zip bold.zip
        
        (one of the commands exited with non-zero exit code; note that snakemake uses bash strict mode!)

[Tue Feb 24 21:52:46 2026]
Error in rule download_zipfile:
    jobid: 10
    output: backbone.zip
    log: logs/download.backbone.zip.log (check log file(s) for error details)
    shell:
        
        curl -L -o $TMPDIR/backbone.zip https://hosted-datasets.gbif.org/datasets/backbone/current/backbone.zip > logs/download.backbone.zip.log 2>&1
        mv $TMPDIR/backbone.zip backbone.zip
        
        (one of the commands exited with non-zero exit code; note that snakemake uses bash strict mode!)

Shutting down, this might take some time.
Exiting because a job execution failed. Look above for error message
Complete log: .snakemake/log/2026-02-24T215245.554823.snakemake.log
```

