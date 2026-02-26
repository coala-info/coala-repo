# plothic CWL Generation Report

## plothic

### Tool Description
Plot Whole genome Hi-C contact matrix heatmap

### Metadata
- **Docker Image**: quay.io/biocontainers/plothic:1.0.0--pyh5707d69_0
- **Homepage**: https://github.com/Jwindler/PlotHiC
- **Package**: https://anaconda.org/channels/bioconda/packages/plothic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/plothic/overview
- **Total Downloads**: 1.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/Jwindler/PlotHiC
- **Stars**: N/A
### Original Help Text
```text
usage: plothic [-h] [-hic HIC_FILE] [-chr CHR_TXT] [-matrix MATRIX]
               [--abs-bed ABS_BED] [-o OUTPUT] [-order]
               [--abs-order ABS_ORDER] [--hic-split HIC_SPLIT] [--bed-split]
               [-g GENOME_NAME] [-r RESOLUTION] [-d DATA_TYPE]
               [-n NORMALIZATION] [-log] [-cmap CMAP] [-format FORMAT]
               [-f FIG_SIZE] [-dpi DPI] [--bar-min BAR_MIN]
               [--bar-max BAR_MAX] [-rotation ROTATION] [-grid] [--x-axis]
               [-v]

Plot Whole genome Hi-C contact matrix heatmap

options:
  -h, --help            show this help message and exit
  -hic HIC_FILE, --hic-file HIC_FILE
                        Path to the Hi-C file
  -chr CHR_TXT, --chr-txt CHR_TXT
                        Path to the chromosome text file
  -matrix MATRIX        Path to the HiCPro matrix file
  --abs-bed ABS_BED     Path to the HiCPro abs bed file
  -o OUTPUT, --output OUTPUT
                        Output directory, default: ./
  -order                Order the heatmap by specific order, for hic format,
                        default: False
  --abs-order ABS_ORDER
                        Path to the HiCPro abs order file
  --hic-split HIC_SPLIT
                        Plot the heatmap by split chromosome (hic format)
  --bed-split           Plot the heatmap by split chromosome (HiCPro format)
  -g GENOME_NAME, --genome-name GENOME_NAME
                        Genome name for the heatmap
  -r RESOLUTION, --resolution RESOLUTION
                        Resolution for Hi-C data
  -d DATA_TYPE, --data-type DATA_TYPE
                        Data type for Hi-C data or "oe" (observed/expected),
                        default: observed
  -n NORMALIZATION, --normalization NORMALIZATION
                        Normalization method for Hi-C data (NONE, VC, VC_SQRT,
                        KR, SCALE, etc.), default: NONE
  -log                  Log2 transform the data
  -cmap CMAP            Color map for the heatmap, default: YlOrRd
  -format FORMAT        Output format for the figure, default: pdf
  -f FIG_SIZE, --fig-size FIG_SIZE
                        Figure size, default: 10
  -dpi DPI              DPI for the output figure, default: 300
  --bar-min BAR_MIN     Minimum value for color bar, default: 0
  --bar-max BAR_MAX     Maximum value for color bar
  -rotation ROTATION    Rotation for the x and y axis labels, default: 45
  -grid                 Show grid in the heatmap, Default: True
  --x-axis              Show genome size at x-axis, Default: False
  -v, --version         show program's version number and exit
```

