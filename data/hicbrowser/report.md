# hicbrowser CWL Generation Report

## hicbrowser_runBrowser

### Tool Description
Activate HiCBrowser using a given configuration file.

### Metadata
- **Docker Image**: quay.io/biocontainers/hicbrowser:1.0--py27_1
- **Homepage**: https://github.com/maxplanck-ie/HiCBrowser
- **Package**: https://anaconda.org/channels/bioconda/packages/hicbrowser/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hicbrowser/overview
- **Total Downloads**: 6.2K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/maxplanck-ie/HiCBrowser
- **Stars**: N/A
### Original Help Text
```text
usage: runBrowser [-h] --config CONFIG [--port PORT] [--htmlFolder HTMLFOLDER]
                  [--numProcessors NUMPROCESSORS] [--debug] [--version]

Activate HiCBrowser using a given configuration file.

optional arguments:
  -h, --help            show this help message and exit
  --config CONFIG, -c CONFIG
                        Configuration file with genomic tracks. (default:
                        None)
  --port PORT, -p PORT  Local browser port to use. (default: 8000)
  --htmlFolder HTMLFOLDER
                        File where the template index.html file is located.
                        The default isfine unless the contents wants to be
                        personalized. The full path has to be given. (default:
                        None)
  --numProcessors NUMPROCESSORS, -np NUMPROCESSORS
                        Number of processors to use. (default: 1)
  --debug               Set to run the server in debug mode which will print
                        useful information. (default: False)
  --version             show program's version number and exit
```

