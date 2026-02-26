# elastix CWL Generation Report

## elastix

### Tool Description
elastix registers a moving image to a fixed image.
The registration-process is specified in the parameter file.

### Metadata
- **Docker Image**: biocontainers/elastix:v4.9.0-1-deb_cv1
- **Homepage**: https://github.com/SuperElastix/elastix
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/elastix/overview
- **Total Downloads**: N/A
- **Last updated**: N/A
- **GitHub**: https://github.com/SuperElastix/elastix
- **Stars**: N/A
### Original Help Text
```text
elastix version: 4.900

elastix registers a moving image to a fixed image.
The registration-process is specified in the parameter file.
  --help, -h displays this message and exit
  --version  output version information and exit

Call elastix from the command line with mandatory arguments:
  -f        fixed image
  -m        moving image
  -out      output directory
  -p        parameter file, elastix handles 1 or more "-p"

Optional extra commands:
  -fMask    mask for fixed image
  -mMask    mask for moving image
  -t0       parameter file for initial transform
  -priority set the process priority to high, abovenormal, normal (default),
            belownormal, or idle (Windows only option)
  -threads  set the maximum number of threads of elastix

The parameter-file must contain all the information necessary for elastix to run properly. That includes which metric to use, which optimizer, which transform, etc. It must also contain information specific for the metric, optimizer, transform, etc. For a usable parameter-file, see the website.

Need further help?
Check the website http://elastix.isi.uu.nl, or mail elastix@bigr.nl.
```

