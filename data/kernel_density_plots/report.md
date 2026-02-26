# kernel_density_plots CWL Generation Report

## kernel_density_plots_kernel_plot.py

### Tool Description
Kernel Plot Tool

### Metadata
- **Docker Image**: quay.io/biocontainers/kernel_density_plots:0.1--pyhdfd78af_0
- **Homepage**: https://github.com/kapurlab/kernel_density_plots
- **Package**: https://anaconda.org/channels/bioconda/packages/kernel_density_plots/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kernel_density_plots/overview
- **Total Downloads**: 266
- **Last updated**: 2025-05-02
- **GitHub**: https://github.com/kapurlab/kernel_density_plots
- **Stars**: N/A
### Original Help Text
```text
usage: kernel_plot.py [-h] -f INPUT_FASTA [--lineage LINEAGE]
                      [--outputdir OUTPUTDIR] [--density-xlim DENSITY_XLIM]
                      [--neighbor-xlim NEIGHBOR_XLIM] [--bin-size BIN_SIZE]
                      [--width WIDTH] [--height HEIGHT]
                      [--title-size TITLE_SIZE]
                      [--axis-title-size AXIS_TITLE_SIZE]
                      [--axis-text-size AXIS_TEXT_SIZE]
                      [--annotation-size ANNOTATION_SIZE] [--no-annotations]
                      [--theme {light,minimal,classic,gray,dark,bw}] [-v]

Kernel Plot Tool

options:
  -h, --help            show this help message and exit
  -f, --fasta INPUT_FASTA
                        Input FASTA file
  --lineage LINEAGE     Specify lineage/group name (optional)
  --outputdir OUTPUTDIR
                        Output directory (default: creates folder next to
                        input file)
  --density-xlim DENSITY_XLIM
                        Density plot X-axis limit (default: 1400)
  --neighbor-xlim NEIGHBOR_XLIM
                        Closest neighbor X-axis limit (default: 600)
  --bin-size BIN_SIZE   Histogram bin size (default: 25)
  --width WIDTH         Plot width in inches (default: 7)
  --height HEIGHT       Plot height in inches (default: 5)
  --title-size TITLE_SIZE
                        Title text size (default: 18)
  --axis-title-size AXIS_TITLE_SIZE
                        Axis title text size (default: 14)
  --axis-text-size AXIS_TEXT_SIZE
                        Axis text size (default: 12)
  --annotation-size ANNOTATION_SIZE
                        Annotation text size (default: 6)
  --no-annotations      Hide text annotations on plots
  --theme {light,minimal,classic,gray,dark,bw}
                        Plot theme (default: light)
  -v, --version         show program's version number and exit

Example:
  python kernel_plot.py --lineage=MyGroup --bin-size=20 input.fasta
```

