# shiba2sashimi CWL Generation Report

## shiba2sashimi

### Tool Description
Create Sashimi plot from Shiba output

### Metadata
- **Docker Image**: quay.io/biocontainers/shiba2sashimi:0.1.7--pyh7e72e81_0
- **Homepage**: https://github.com/Sika-Zheng-Lab/shiba2sashimi
- **Package**: https://anaconda.org/channels/bioconda/packages/shiba2sashimi/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/shiba2sashimi/overview
- **Total Downloads**: 1.9K
- **Last updated**: 2025-08-09
- **GitHub**: https://github.com/Sika-Zheng-Lab/shiba2sashimi
- **Stars**: N/A
### Original Help Text
```text
usage: shiba2sashimi [-h] -e EXPERIMENT -s SHIBA -o OUTPUT [--id ID]
                     [-c COORDINATE] [--samples SAMPLES] [--groups GROUPS]
                     [--colors COLORS] [--width WIDTH] [--extend_up EXTEND_UP]
                     [--extend_down EXTEND_DOWN]
                     [--smoothing_window_size SMOOTHING_WINDOW_SIZE]
                     [--font_family FONT_FAMILY] [--nolabel] [--nojunc]
                     [--minimum_junc_reads MINIMUM_JUNC_READS] [--dpi DPI]
                     [-v]

shiba2sashimi v0.1.7 - Create Sashimi plot from Shiba output

options:
  -h, --help            show this help message and exit
  -e EXPERIMENT, --experiment EXPERIMENT
                        Experiment table used for Shiba
  -s SHIBA, --shiba SHIBA
                        Shiba working directory
  -o OUTPUT, --output OUTPUT
                        Output file
  --id ID               Positional ID (pos_id) of the event to plot
  -c COORDINATE, --coordinate COORDINATE
                        Coordinates of the region to plot
  --samples SAMPLES     Samples to plot. e.g. sample1,sample2,sample3 Default:
                        all samples in the experiment table
  --groups GROUPS       Groups to plot. e.g. group1,group2,group3 Default: all
                        groups in the experiment table. Overrides --samples
  --colors COLORS       Colors for each group. e.g. red,orange,blue
  --width WIDTH         Width of the output figure. Default: 8
  --extend_up EXTEND_UP
                        Extend the plot upstream. Only used when not providing
                        coordinates. Default: 500
  --extend_down EXTEND_DOWN
                        Extend the plot downstream. Only used when not
                        providing coordinates. Default: 500
  --smoothing_window_size SMOOTHING_WINDOW_SIZE
                        Window size for median filter to smooth coverage plot.
                        Greater value gives smoother plot. Default: 21
  --font_family FONT_FAMILY
                        Font family for labels
  --nolabel             Do not add sample labels and PSI values to the plot
  --nojunc              Do not plot junction arcs and junction read counts to
                        the plot
  --minimum_junc_reads MINIMUM_JUNC_READS
                        Minimum number of reads to plot a junction arc.
                        Default: 1
  --dpi DPI             DPI of the output figure. Default: 300
  -v, --verbose         Increase verbosity
```

