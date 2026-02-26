# pyfish CWL Generation Report

## pyfish

### Tool Description
Create a Fish (Muller) plot for the given evolutionary tree.

### Metadata
- **Docker Image**: quay.io/biocontainers/pyfish:1.0.3--pyh7cba7a3_0
- **Homepage**: https://bitbucket.org/schwarzlab/pyfish
- **Package**: https://anaconda.org/channels/bioconda/packages/pyfish/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pyfish/overview
- **Total Downloads**: 7.5K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: pyfish [-h] [-a] [-I INTERPOLATION] [-S SMOOTH] [-F FIRST_STEP]
              [-L LAST_STEP] [-R SEED] [-M CMAP] [-C COLOR_BY] [-W WIDTH]
              [-H HEIGHT]
              populations parent_tree output

Create a Fish (Muller) plot for the given evolutionary tree.

positional arguments:
  populations           A CSV file with the header "Id,Step,Pop".
  parent_tree           A CSV file with the header "ParentId,ChildId".
  output                Output image filepath. The format must support alpha
                        channels.

options:
  -h, --help            show this help message and exit
  -a, --absolute        Plot the populations in absolute numbers rather than
                        normalized.
  -I INTERPOLATION, --interpolation INTERPOLATION
                        Order of interpolation for empty data (0 means no
                        interpolation).
  -S SMOOTH, --smooth SMOOTH
                        STDev for Gaussian convolutional filter. The higher
                        the value the smoother the resulting bands will be.
                        Recommended is around 1.0.
  -F FIRST_STEP, --first FIRST_STEP
                        The step to start plotting from.
  -L LAST_STEP, --last LAST_STEP
                        The step to end the plotting at.
  -R SEED, --seed SEED  Random seed for selection of colors.
  -M CMAP, --cmap CMAP  Colormap to use. Has to be a matplotlib colormap Uses
                        rainbow by default
  -C COLOR_BY, --color-by COLOR_BY
                        Color the fishplot based on this column of the
                        populations dataframe
  -W WIDTH, --width WIDTH
                        Output image width
  -H HEIGHT, --height HEIGHT
                        Output image height
```

