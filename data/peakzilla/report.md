# peakzilla CWL Generation Report

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

