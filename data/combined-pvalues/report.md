# combined-pvalues CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| combined-pvalues_acf | PASS | Upstream test data pvals.bed; N per lag matches expected_acf.txt, correlations differ slightly because that file predates the switch to rank correlation. |
| combined-pvalues_fdr | PASS |  |
| combined-pvalues_filter | Failed | image problem: bedtools is missing from the image, so filter fails with 'bedtools: command not found' and writes nothing. |
| combined-pvalues_hist | PASS |  |
| combined-pvalues_manhattan | Failed | image problem: matplotlib is missing from the image (ImportError), so no plot is made. |
| combined-pvalues_peaks | PASS |  |
| combined-pvalues_pipeline | PASS | Upstream example file.bed gives the expected acf, slk, fdr, regions and regions-p files; the optional --region-filter-p/-n step needs bedtools, which the image lacks, so regions-t.bed stays empty. |
| combined-pvalues_region_p | PASS |  |
| combined-pvalues_slk | PASS |  |

## combined-pvalues_acf

### Tool Description
calculate the autocorrelation of a *sorted* bed file with a set of *distance* lags.

### Metadata
- **Docker Image**: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
- **Homepage**: https://github.com/brentp/combined-pvalues
- **Package**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brentp/combined-pvalues
- **Stars**: N/A
### Original Help Text
```text
usage: comb-p [-h] [-d D] [-c C] [--full] files [files ...]

   calculate the autocorrelation of a *sorted* bed file with a set
   of *distance* lags.

positional arguments:
  files       files to process

optional arguments:
  -h, --help  show this help message and exit
  -d D        start:stop:stepsize of distance. e.g. 15:500:50 means check acf
              at distances of:[15, 65, 115, 165, 215, 265, 315, 365, 415, 465]
  -c C        column number with p-values for acf calculations
  --full      do full autocorrelation (default is partial)
```

## combined-pvalues_slk

### Tool Description
Stouffer-Liptak-Kechris correction of correlated p-values

### Metadata
- **Docker Image**: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
- **Homepage**: https://github.com/brentp/combined-pvalues
- **Package**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brentp/combined-pvalues
- **Stars**: N/A
### Original Help Text
```text
usage: comb-p [-h] [--acf ACF] [-c C] files [files ...]

positional arguments:
  files       files to process

optional arguments:
  -h, --help  show this help message and exit
  --acf ACF   acf file containing the lagged correlations. This tells the
              program the max distance as well as the distance lags.
  -c C        column number that has the value to take the acf
```

## combined-pvalues_fdr

### Tool Description
perform Benjamini-Hochberg FDR correction on a BED file with p-values.

### Metadata
- **Docker Image**: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
- **Homepage**: https://github.com/brentp/combined-pvalues
- **Package**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brentp/combined-pvalues
- **Stars**: N/A
### Original Help Text
```text
usage: comb-p [-h] [-c C] [--qvality] [--null NULL] bed_file

perform Benjamini-Hochberg FDR correction on a BED file with p-values.

positional arguments:
  bed_file     bed file to correct

optional arguments:
  -h, --help   show this help message and exit
  -c C         column number of the pvalues
  --qvality    if specified --null must also be specified and qvality" " must
               be on the path
  --null NULL  (optional) column number of the pvalues under the null, e.g.
               for shuffled data is used to do the correction. Otherwise,
               Benjamini-Hochberg is used
```

## combined-pvalues_peaks

### Tool Description
find peaks or troughs in sorted bed files

### Metadata
- **Docker Image**: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
- **Homepage**: https://github.com/brentp/combined-pvalues
- **Package**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brentp/combined-pvalues
- **Stars**: N/A
### Original Help Text
```text
usage: 
find peaks or troughs in sorted bed files

for a bedgraph file with pvalues in the 4th column. usage would be:

    $ python peaks.py --dist 100 --seed 0.01 some.bed > some.regions.bed

where some.regions.bed contains the start and end of the region and (currently)
the lowest p-value in that region.

       [-h] [--dist DIST] [--seed SEED] [--threshold THRESHOLD] [--invert]
       [-c C]
       bed_file

positional arguments:
  bed_file

optional arguments:
  -h, --help            show this help message and exit
  --dist DIST           Maximum dist to skip before finding a seed/thresh
                        value. If this number is exceeded, the region is
                        ended.
  --seed SEED           A value must be at least this large/small in order to
                        seed a region.
  --threshold THRESHOLD
                        After seeding, a value of at least this number can
                        extend a region.
  --invert              by default, the test is for a value less-than seed or
                        thresh--e.g. for p-values. If this flag is specified,
                        the test is for greater-than--e.g. for scores or
                        -log10(p-values)
  -c C                  column number containing the value for which to find
                        peaks.
```

## combined-pvalues_region_p

### Tool Description
calculate a p-value of a region using the Stouffer-Liptak method or the z-score method.

### Metadata
- **Docker Image**: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
- **Homepage**: https://github.com/brentp/combined-pvalues
- **Package**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brentp/combined-pvalues
- **Stars**: N/A
### Original Help Text
```text
usage: comb-p [-h] [-p PVALS] [-r REGIONS] [-s STEP] [-c C] [-z]

   calculate a p-value of a region using the Stouffer-Liptak method or the
   z-score method.

optional arguments:
  -h, --help            show this help message and exit
  -p PVALS              BED containing all the p values used to generate
                        `regions`
  -r REGIONS            BED containing all the regions
  -s STEP, --step STEP  step size for acf calculation. should be the same
                        value as the step sent to -d arg for acf
  -c C                  column number containing the p-value of interest
  -z                    use z-score correction
```

## combined-pvalues_filter

### Tool Description
count the number of switches in sign in the regions and output the region_bed intervals with the sum of positive and negative t-scores.

### Metadata
- **Docker Image**: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
- **Homepage**: https://github.com/brentp/combined-pvalues
- **Package**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brentp/combined-pvalues
- **Stars**: N/A
### Original Help Text
```text
usage: comb-p [-h] [-p P] [-t T] [--coef COEF] [--filter] [--max-p MAX_P]
              [--region-p REGION_P]
              region_bed p_bed

count the number of switches in sign in the regions. Since the region
calculation is based on the p-value only, it could be that a region is
discovered that has both high and low t-scores.
This script will output the original region_bed intervals, along with
sum of positive t-scores and the sum of negative t-scores.

positional arguments:
  region_bed           file containing the regions
  p_bed                file containing the raw p-values

optional arguments:
  -h, --help           show this help message and exit
  -p P                 p-value column from `p_bed`
  -t T                 t-statistic or directionality from p_bed
  --coef COEF          name of coefficient column in BED
  --filter             don't print row if there's a swith in t-scores
  --max-p MAX_P        filter regions with any p-value > this value
  --region-p REGION_P  filter regions with combined p-value > this value
```

## combined-pvalues_hist

### Tool Description
draw a histogram of the distribution of a given column and check for uniformity with the chisq test.

### Metadata
- **Docker Image**: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
- **Homepage**: https://github.com/brentp/combined-pvalues
- **Package**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brentp/combined-pvalues
- **Stars**: N/A
### Original Help Text
```text
usage: comb-p [-h] [-c C] [-n N] file

draw a histogram of the distribution of a given column
and check for uniformity with the chisq test.

positional arguments:
  file        bed file to correct

optional arguments:
  -h, --help  show this help message and exit
  -c C        column number for the histogram
  -n N        number of bins in the histogram
```

## combined-pvalues_manhattan

### Tool Description
a manhattan plot of values in a BED file.

### Metadata
- **Docker Image**: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
- **Homepage**: https://github.com/brentp/combined-pvalues
- **Package**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brentp/combined-pvalues
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/comb-p", line 39, in <module>
    main()
  File "/usr/local/bin/comb-p", line 35, in main
    module = getattr(__import__('cpv', fromlist=[action]), action)
  File "/usr/local/lib/python2.7/site-packages/cpv/manhattan.py", line 15, in <module>
    import matplotlib
ImportError: No module named matplotlib
```

## combined-pvalues_pipeline

### Tool Description
run acf, slk, fdr, peaks, region_p in succession

### Metadata
- **Docker Image**: quay.io/biocontainers/combined-pvalues:0.50.6--pyhdfd78af_0
- **Homepage**: https://github.com/brentp/combined-pvalues
- **Package**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/combined-pvalues/overview
- **Total Downloads**: 22.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/brentp/combined-pvalues
- **Stars**: N/A
### Original Help Text
```text
usage: comb-p [-h] [-c C] --dist DIST [--acf-dist ACF_DIST] [--step STEP]
              [--seed SEED] [--threshold THRESHOLD] [--no-fdr] [-p PREFIX]
              [--genomic-control] [--region-filter-p REGION_FILTER_P]
              [--region-filter-n REGION_FILTER_N] [--annotate ANNOTATE]
              [--table TABLE]
              bed_files [bed_files ...]

positional arguments:
  bed_files             sorted bed file to process

optional arguments:
  -h, --help            show this help message and exit
  -c C                  column number that has the value totake the acf
  --dist DIST, --distance--peak-dist DIST
                        Maximum dist to search for adjacent peaks.
  --acf-dist ACF_DIST   distance/window-size to use for smoothing. Defaults to
                        1/3 * peak-dist
  --step STEP           step size for bins in the ACF calculation
  --seed SEED           A value must be at least this large/small in order to
                        seed a region.
  --threshold THRESHOLD
                        After seeding, a value of at least this number can
                        extend a region.
  --no-fdr              Don't use FDR-corrected p-values for finding peaks
                        (either way, we still do multiple-testing correction
                        on the p-values for the regions).
  -p PREFIX, --prefix PREFIX
                        prefix for output files
  --genomic-control     perform the genomic control correction on the input
                        pvalues
  --region-filter-p REGION_FILTER_P
                        max adjusted region-level p-value to be reported in
                        final output. this requires the input bed file to have
                        chrom, start, end, 't' columns
  --region-filter-n REGION_FILTER_N
                        require at least this many probesfor a region to be
                        reported in final output. this requires the input bed
                        file to have chrom, start, end, 't' columns
  --annotate ANNOTATE   annotate with a gene table from this db in UCSC (e.g.
                        hg19) requires cruzdb
  --table TABLE         annotate with this gene table from a db in UCSC
                        (default is refGene) requires cruzdb
```
