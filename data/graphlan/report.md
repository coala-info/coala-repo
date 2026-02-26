# graphlan CWL Generation Report

## graphlan

### Tool Description
GraPhlAn 1.1.3 (5 June 2018) AUTHORS: Nicola Segata (nsegata@hsph.harvard.edu)

### Metadata
- **Docker Image**: biocontainers/graphlan:v1.1.3-1-deb_cv1
- **Homepage**: https://bitbucket.org/nsegata/graphlan/wiki/Home
- **Package**: https://anaconda.org/channels/bioconda/packages/graphlan/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/graphlan/overview
- **Total Downloads**: 19.4K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
usage: graphlan [-h] [--format ['output_image_format']] [--warnings WARNINGS]
                [--positions POSITIONS] [--dpi image_dpi] [--size image_size]
                [--pad pad_in] [--external_legends] [--avoid_reordering] [-v]
                input_tree output_image

GraPhlAn 1.1.3 (5 June 2018) AUTHORS: Nicola Segata (nsegata@hsph.harvard.edu)

positional arguments:
  input_tree            the input tree in PhyloXML format
  output_image          the output image, the format is guessed from the
                        extension unless --format is given. Available file
                        formats are: png, pdf, ps, eps, svg

optional arguments:
  -h, --help            show this help message and exit
  --format ['output_image_format']
                        set the format of the output image (default none
                        meaning that the format is guessed from the output
                        file extension)
  --warnings WARNINGS   set whether warning messages should be reported or not
                        (default 1)
  --positions POSITIONS
                        set whether the absolute position of the points should
                        be reported on the standard output. The two
                        cohordinates are r and theta
  --dpi image_dpi       the dpi of the output image for non vectorial formats
  --size image_size     the size of the output image (in inches, default 7.0)
  --pad pad_in          the distance between the most external graphical
                        element and the border of the image
  --external_legends    specify whether the two external legends should be put
                        in separate file or keep them along with the image
                        (default behavior)
  --avoid_reordering    specify whether the tree will be reorder or not
                        (default the tree will be reordered)
  -v, --version         Prints the current GraPhlAn version and exit
```

