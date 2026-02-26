# virheat CWL Generation Report

## virheat

### Tool Description
Generates a heatmap visualization of genetic variants.

### Metadata
- **Docker Image**: quay.io/biocontainers/virheat:0.7.6--pyhdfd78af_0
- **Homepage**: https://github.com/jonas-fuchs/virHEAT
- **Package**: https://anaconda.org/channels/bioconda/packages/virheat/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/virheat/overview
- **Total Downloads**: 4.7K
- **Last updated**: 2025-08-12
- **GitHub**: https://github.com/jonas-fuchs/virHEAT
- **Stars**: N/A
### Original Help Text
```text
usage: 	virheat <folder containing input files (vcf/tsv)> <output dir> -r -l/-g [additional arguments]

positional arguments:
  input                 folder containing input files and output folder

options:
  -h, --help            show this help message and exit
  -r ref_id, --reference ref_id
                        reference identifier
  --name virHEAT_plot.pdf
                        plot name and file type (pdf, png, svg, jpg). Default:
                        virHEAT_plot.pdf
  -l None, --genome-length None
                        length of the genome (needed if gff3 is not provided)
  -g None, --gff3-path None
                        path to gff3 (needed if length is not provided)
  -a [gene ...], --gff3-annotations [gene ...]
                        annotations to display from gff3 file (standard:
                        gene). Multiple possible.
  --gene-arrows, --no-gene-arrows
                        show genes as arrows
  -t  , --threshold     display variant frequencies between upper and lower
                        thresholds (0-1)
  --delete, --no-delete
                        delete mutations that are present in all samples and
                        their maximum frequency divergence is smaller than 0.5
  -n None, --delete-n None
                        do not show mutations that occur n times or less
                        (default: Do not delete)
  -z start stop, --zoom start stop
                        restrict the plot to a specific genomic region.
  --sort, --no-sort     sort sample names alphanumerically
  --min-cov 20          display mutations covered at least x time (only if per
                        base cov tsv files are provided)
  -s scores_file pos_col score_col score_name, --scores scores_file pos_col score_col score_name
                        Experimental setting (specific for SARS-CoV-2)!
                        Specify scores to be added to the plot by providing a
                        CSV file containing scores, along with its column for
                        amino-acid positions, its column for scores, and
                        descriptive score names (e.g., expression, binding,
                        antibody escape, etc.). This option can be used
                        multiple times to include multiple sets of scores.
  -v, --version         show program's version number and exit
```

