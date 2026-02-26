# ashlar CWL Generation Report

## ashlar

### Tool Description
Stitch and align multi-tile cyclic microscope images

### Metadata
- **Docker Image**: quay.io/biocontainers/ashlar:1.19.0--pyhdfd78af_0
- **Homepage**: https://github.com/sorgerlab/ashlar
- **Package**: https://anaconda.org/channels/bioconda/packages/ashlar/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ashlar/overview
- **Total Downloads**: 6.4K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sorgerlab/ashlar
- **Stars**: N/A
### Original Help Text
```text
usage: ashlar [-h] [-o PATH] [-c CHANNEL] [--flip-x] [--flip-y]
              [--flip-mosaic-x] [--flip-mosaic-y]
              [--output-channels CHANNEL [CHANNEL ...]] [-m SHIFT]
              [--stitch-alpha ALPHA] [--filter-sigma SIGMA]
              [--tile-size PIXELS] [--ffp FILE [FILE ...]]
              [--dfp FILE [FILE ...]] [--plates] [-q] [--version]
              FILE [FILE ...]

Stitch and align multi-tile cyclic microscope images

positional arguments:
  FILE                  Image file(s) to be processed, one per cycle

options:
  -h, --help            Show this help message and exit
  -o PATH, --output PATH
                        Output file. If PATH ends in .ome.tif a pyramidal OME-
                        TIFF will be written. If PATH ends in just .tif and
                        includes {cycle} and {channel} placeholders, a series
                        of single-channel plain TIFF files will be written. If
                        PATH starts with a relative or absolute path to
                        another directory, that directory must already exist.
                        (default: ashlar_output.ome.tif)
  -c CHANNEL, --align-channel CHANNEL
                        Reference channel number for image alignment.
                        Numbering starts at 0. (default: 0)
  --flip-x              Flip tile positions left-to-right
  --flip-y              Flip tile positions top-to-bottom
  --flip-mosaic-x       Flip output image left-to-right
  --flip-mosaic-y       Flip output image top-to-bottom
  --output-channels CHANNEL [CHANNEL ...]
                        Output only specified channels for each cycle.
                        Numbering starts at 0. (default: all channels)
  -m SHIFT, --maximum-shift SHIFT
                        Maximum allowed per-tile corrective shift in microns
                        (default: 15)
  --stitch-alpha ALPHA  Significance level for permutation testing during
                        alignment error quantification. Larger values include
                        more tile pairs in the spanning tree at the cost of
                        increased false positives. (default: 0.01)
  --filter-sigma SIGMA  Filter images before alignment using a Gaussian kernel
                        with s.d. of SIGMA pixels (default: no filtering)
  --tile-size PIXELS    Pyramid tile size for OME-TIFF output (default: 1024)
  --ffp FILE [FILE ...]
                        Perform flat field illumination correction using the
                        given profile image. Specify one common file for all
                        cycles or one file for every cycle. Channel counts
                        must match input files. (default: no flat field
                        correction)
  --dfp FILE [FILE ...]
                        Perform dark field illumination correction using the
                        given profile image. Specify one common file for all
                        cycles or one file for every cycle. Channel counts
                        must match input files. (default: no dark field
                        correction)
  --plates              Enable plate mode for HTS data
  -q, --quiet           Suppress progress display
  --version             Show program's version number and exit
```

