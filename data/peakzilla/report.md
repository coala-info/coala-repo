# peakzilla CWL Generation Report

## peakzilla

### Tool Description
The provided text does not contain help information as the executable was not found in the environment.

### Metadata
- **Docker Image**: quay.io/biocontainers/peakzilla:1.0--py36_1
- **Homepage**: https://github.com/steinmann/peakzilla
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/peakzilla/overview
- **Total Downloads**: 9.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/steinmann/peakzilla
- **Stars**: N/A
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
INFO:    Extracting OCI image...
2026/02/14 04:36:06  warn rootless{dev/console} creating empty file in place of device 5:1
INFO:    Inserting Apptainer configuration...
INFO:    Creating SIF file...
WARNING: Skipping mount /var/lib/apptainer/mnt/session/etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container
FATAL:   "peakzilla": executable file not found in $PATH
```


## Metadata
- **Skill**: generated

## peakzilla_peakzilla.py

### Tool Description
Identify peaks from ChIP-seq data using a model-based approach.

### Metadata
- **Docker Image**: quay.io/biocontainers/peakzilla:1.0--py36_1
- **Homepage**: https://github.com/steinmann/peakzilla
- **Package**: Not found
- **Validation**: PASS
### Original Help Text
```text
Usage: python peakzilla.py [OPTIONS] chip.bed control.bed > results.tsv

Options:
  -h, --help            show this help message and exit
  -m N_MODEL_PEAKS, --model_peaks=N_MODEL_PEAKS
                        number of most highly enriched regions used to
                        estimate peak size: default = 200
  -c ENRICHMENT_CUTOFF, --enrichment_cutoff=ENRICHMENT_CUTOFF
                        minimum cutoff for fold enrichment: default = 2
  -s SCORE_CUTOFF, --score_cutoff=SCORE_CUTOFF
                        minimum cutoff for peak score: default = 1
  -f FRAGMENT_SIZE, --fragment_size=FRAGMENT_SIZE
                        manually set fragment size in bp: default = estimate
                        from data
  -e, --gaussian        use empirical model estimate instead of gaussian
  -p, --bedpe           input is paired end and in BEDPE format
  -l LOG, --log=LOG     directory/filename to store log file to: default =
                        log.txt
  -n, --negative        write negative peaks to negative_peaks.tsv
```

