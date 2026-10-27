# xcftools CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| xcftools_xcf2png | PASS |  |
| xcftools_xcf2pnm | PASS |  |
| xcftools_xcfinfo | PASS |  |

## xcftools_xcf2pnm

### Tool Description
Convert GIMP XCF files to PNM format

### Metadata
- **Docker Image**: quay.io/biocontainers/xcftools:1.0.7--0
- **Homepage**: https://github.com/j-jorge/xcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/xcftools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: xcf2pnm [options] filename.xcf[.gz] [layers]
Options:
  -h          show this message (--help)
  -V          show version (--version)
  -v          show progress messages (--verbose)
  -j          input is bzip2 compressed (--bzip)
  -z          input is gzip compressed (--gzip)
  -Z command  use 'command' to decompress input (--unpack)
  -o filename name output file (--output)
  -a filename write transparency map (--alpha)
  -b color    select background color (--background)
  -A          force alpha channel in output (--force-alpha)
  -c          select color output (--color)
  -g          select grayscale output (--gray)
  -m          select monochrome output (--mono)
  -n          select -c/-g/-m by image contents (--pnm)
  -T          treat indexed images as RGB for flattening (--truecolor)
  -G          disallow partial transparency (--for-gif)
  -D          dissolve partial transparency (--dissolve)
  -f          flatten to memory; then analyse (--full-image)
  -S wxh      crop image while converting (--size)
  -O x,y      translate converted part of image (--offset)
  -C          autocrop to visible layer boundaries (--autocrop)
Layer-selection options:
  --mode mode set layer mode
  --percent n set opacity in percent
  --opacity n set opacity in 1/255 units
  --mask      enable layer mask
  --nomask    disable layer mask
  -u          use UTF-8 for layer names (--utf8)
```

## xcftools_xcfinfo

### Tool Description
Print the size, mode and layers of a GIMP XCF file

### Metadata
- **Docker Image**: quay.io/biocontainers/xcftools:1.0.7--0
- **Homepage**: https://github.com/j-jorge/xcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/xcftools/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: xcfinfo [options] filename.xcf[.gz]
Options:
  -h         show this message (--help)
  -V         show version (--version)
  -v         show progress messages (--verbose)
  -j         input is bzip2 compressed (--bzip)
  -p string  use 'string' to separate the groups in the paths (--path-separator)
  -z         input is gzip compressed (--gzip)
  -Z command use 'command' to decompress input (--unpack)
  -u         use UTF-8 for layer names (--utf8)
```

## Metadata
- **Skill**: generated

## xcftools_xcf2png

### Tool Description
Convert GIMP XCF files to PNG format

### Metadata
- **Docker Image**: quay.io/biocontainers/xcftools:1.0.7--0
- **Homepage**: https://github.com/j-jorge/xcftools
- **Package**: https://anaconda.org/channels/bioconda/packages/xcftools/overview
- **Validation**: PASS
### Original Help Text
```text
INFO:    Environment variable SINGULARITY_CACHEDIR is set, but APPTAINER_CACHEDIR is preferred
INFO:    Converting OCI blobs to SIF format
INFO:    Starting build...
INFO:    Fetching OCI image...
FATAL:   Unable to handle docker://quay.io/biocontainers/xcftools:1.0.7--0 uri: while building SIF from layers: conveyor failed to get: invalid character '}' after top-level value
```

