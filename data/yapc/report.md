# yapc CWL Generation Report

## yapc

### Tool Description
An adhoc peak caller for genomic high-throughput sequencing data such as ATAC-seq, DNase-seq or ChIP-seq. Specifically written for the purpose of capturing representative peaks of characteristic width in a time series data set with two biological replicates per time point. Briefly, candidate peak locations are defined using concave regions (regions with negative smoothed second derivative) from signal averaged across all samples. The candidate peaks are then tested for condition-specific statistical significance using IDR.

### Metadata
- **Docker Image**: quay.io/biocontainers/yapc:0.1--py_0
- **Homepage**: https://github.com/jurgjn/yapc
- **Package**: https://anaconda.org/channels/bioconda/packages/yapc/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/yapc/overview
- **Total Downloads**: 2.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jurgjn/yapc
- **Stars**: N/A
### Original Help Text
```text
yapc (yet another peak caller) 0.1

usage: yapc [-h] [--smoothing-window-width SMOOTHING_WINDOW_WIDTH]
            [--smoothing-times SMOOTHING_TIMES]
            [--min-concave-region-width MIN_CONCAVE_REGION_WIDTH]
            [--truncate-idr-input TRUNCATE_IDR_INPUT]
            [--fixed-peak-halfwidth FIXED_PEAK_HALFWIDTH] [--pseudoreplicates]
            [--recycle]
            OUTPUT_PREFIX [CONDITION_REP1_REP2 [CONDITION_REP1_REP2 ...]]

An adhoc peak caller for genomic high-throughput sequencing data such as ATAC-
seq, DNase-seq or ChIP-seq. Specifically written for the purpose of capturing
representative peaks of characteristic width in a time series data set with
two biological replicates per time point. Briefly, candidate peak locations
are defined using concave regions (regions with negative smoothed second
derivative) from signal averaged across all samples. The candidate peaks are
then tested for condition-specific statistical significance using IDR.

positional arguments:
  OUTPUT_PREFIX         Prefix to use for all output files
  CONDITION_REP1_REP2   Name of the condition, BigWig files of first and
                        second replicates; all separated by spaces. (default:
                        None)

optional arguments:
  -h, --help            show this help message and exit
  --smoothing-window-width SMOOTHING_WINDOW_WIDTH
                        Width of the smoothing window used for the second
                        derivative track. If the peak calls aren't capturing
                        the peak shape well, try setting this to different
                        values ranging from 75 to 200. (default: 150)
  --smoothing-times SMOOTHING_TIMES
                        Number of times smoothing is applied to the second
                        derivative. (default: 3)
  --min-concave-region-width MIN_CONCAVE_REGION_WIDTH
                        Discard concave regions smaller than the threshold
                        specified. (default: 75)
  --truncate-idr-input TRUNCATE_IDR_INPUT
                        Truncate IDR input to the number of peaks specified.
                        (default: 100000)
  --fixed-peak-halfwidth FIXED_PEAK_HALFWIDTH
                        Set final peak coordinates to the specified number of
                        base pairs on either side of the concave region mode.
                        (default: None)
  --pseudoreplicates    Use pseudoreplicates as implemented in modENCODE
                        (Landt et al 2012; around Fig 7): for each condition,
                        assess peak reproducibility in replicates and
                        pseudoreplicates; report globalIDRs for the set with a
                        larger number of peak calls (at IDR=0.001).
                        Pseudoreplicates are specified as the 3rd and 4th file
                        name after every condition. (default: False)
  --recycle             Do not recompute (intermediate) output files if a file
                        with the expected name is already present. Enabling
                        this can lead to funky behaviour e.g. in the case of a
                        previously interrupted run. (default: False)
```

