# ampliconclassifier CWL Generation Report

## ampliconclassifier

### Tool Description
FAIL to generate CWL: ampliconclassifier not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/ampliconclassifier:0.4.14--hdfd78af_0
- **Homepage**: https://github.com/jluebeck/AmpliconClassifier
- **Package**: https://anaconda.org/channels/bioconda/packages/ampliconclassifier/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/ampliconclassifier/overview
- **Total Downloads**: 7.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jluebeck/AmpliconClassifier
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: ampliconclassifier not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: ampliconclassifier not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## ampliconclassifier_amplicon_classifier.py

### Tool Description
Classify AA amplicon type

### Metadata
- **Docker Image**: quay.io/biocontainers/ampliconclassifier:0.4.14--hdfd78af_0
- **Homepage**: https://github.com/jluebeck/AmpliconClassifier
- **Package**: https://anaconda.org/channels/bioconda/packages/ampliconclassifier/overview
- **Validation**: PASS
### Original Help Text
```text
usage: amplicon_classifier.py [-h] [-i INPUT] [-c CYCLES] [-g GRAPH] --ref
                              {hg19,GRCh37,hg38,GRCh38,GRCh38_viral,mm10,GRCm38}
                              [--min_flow MIN_FLOW] [--min_size MIN_SIZE]
                              [-o O] [--plotstyle {grouped,individual,noplot}]
                              [--force] [--add_chr_tag] [--report_complexity]
                              [--verbose_classification] [--no_LC_filter]
                              [--exclude_bed EXCLUDE_BED]
                              [--decomposition_strictness DECOMPOSITION_STRICTNESS]
                              [--filter_similar] [-v]

Classify AA amplicon type

options:
  -h, --help            show this help message and exit
  -i INPUT, --input INPUT
                        Path to list of files to use. Each line formatted as:
                        sample_name cycles.txt graph.txt. Give this argument
                        if not using -c and -g.
  -c CYCLES, --cycles CYCLES
                        AA-formatted cycles file
  -g GRAPH, --graph GRAPH
                        AA-formatted graph file
  --ref {hg19,GRCh37,hg38,GRCh38,GRCh38_viral,mm10,GRCm38}
                        Reference genome name used for alignment, one of hg19,
                        GRCh37, or GRCh38.
  --min_flow MIN_FLOW   Minimum flow to consider among decomposed paths (1.0).
  --min_size MIN_SIZE   Minimum cycle size (in bp) to consider as valid
                        amplicon (5000).
  -o O                  Output filename prefix
  --plotstyle {grouped,individual,noplot}
                        Type of visualizations to produce.
  --force               Disable No amp/Invalid class if possible
  --add_chr_tag         Add 'chr' to the beginning of chromosome names in
                        input files.
  --report_complexity   Compute a measure of amplicon entropy for each
                        amplicon.
  --verbose_classification
                        Generate verbose output with raw classification
                        scores.
  --no_LC_filter        Do not filter low-complexity cycles. Not recommended
                        to set this flag.
  --exclude_bed EXCLUDE_BED
                        List of regions in which to ignore classification.
  --decomposition_strictness DECOMPOSITION_STRICTNESS
                        Value between 0 and 1 reflecting how strictly to
                        filter low CN decompositions (default = 0.1). Higher
                        values filter more of the low-weight decompositions.
  --filter_similar      Only use if all samples are of independent origins
                        (not replicates and not multi-region biopsies).
                        Permits filtering of false-positive amps arising in
                        multiple independent samples based on similarity
                        calculation
  -v, --version         show program's version number and exit
```

