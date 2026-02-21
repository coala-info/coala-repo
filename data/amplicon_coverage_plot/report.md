# amplicon_coverage_plot CWL Generation Report

## amplicon_coverage_plot

### Tool Description
FAIL to generate CWL: amplicon_coverage_plot not found in Singularity image. The image may not provide this executable.

### Metadata
- **Docker Image**: quay.io/biocontainers/amplicon_coverage_plot:0.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/chienchi/amplicon_coverage_plot
- **Package**: https://anaconda.org/channels/bioconda/packages/amplicon_coverage_plot/overview
- **Validation**: FAIL (generation failed)

- **Conda**: https://anaconda.org/channels/bioconda/packages/amplicon_coverage_plot/overview
- **Total Downloads**: 13.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/chienchi/amplicon_coverage_plot
- **Stars**: N/A
### Generation Failed

FAIL to generate CWL: amplicon_coverage_plot not found in Singularity image. The image may not provide this executable.


### Validation Errors

- FAIL to generate CWL: amplicon_coverage_plot not found in Singularity image. The image may not provide this executable.



### Original Help Text
```text

```


## Metadata
- **Skill**: generated

## amplicon_coverage_plot_amplicov

### Tool Description
Script to parse amplicon region coverage and generate barplot in html

### Metadata
- **Docker Image**: quay.io/biocontainers/amplicon_coverage_plot:0.3.4--pyhdfd78af_0
- **Homepage**: https://github.com/chienchi/amplicon_coverage_plot
- **Package**: https://anaconda.org/channels/bioconda/packages/amplicon_coverage_plot/overview
- **Validation**: PASS
### Original Help Text
```text
usage: amplicov [-h] (--bed [FILE] | --bedpe [FILE])
                (--bam [FILE] | --cov [FILE]) [-o [PATH]] [-p [STR]] [--pp]
                [--count_primer] [--mincov [INT]] [-r [STR]]
                [--depth_lines DEPTH_LINES [DEPTH_LINES ...]] [--gff [FILE]]
                [--version]

Script to parse amplicon region coverage and generate barplot in html

options:
  -h, --help            show this help message and exit
  --pp                  process proper paired only reads from bam file
                        (illumina)
  --count_primer        count overlapped primer region to unqiue coverage
  --mincov [INT]        minimum coverage to count as ambiguous N site
                        [default:10]
  -r [STR], --refID [STR]
                        reference accession (bed file first field)
  --depth_lines DEPTH_LINES [DEPTH_LINES ...]
                        Add option to display lines at these depths (provide
                        depths as a list of integers) [default:5 10 20 50]
  --gff [FILE]          gff file for data hover info annotation
  --version             show program's version number and exit

Amplicon Input (required, mutually exclusive):
  --bed [FILE]          amplicon bed file (bed6 format)
  --bedpe [FILE]        amplicon bedpe file

Coverage Input (required, mutually exclusive):
  --bam [FILE]          sorted bam file (ex: samtools sort input.bam -o
                        sorted.bam)
  --cov [FILE]          coverage file [position coverage]

Output:
  -o [PATH], --outdir [PATH]
                        output directory
  -p [STR], --prefix [STR]
                        output prefix
```

