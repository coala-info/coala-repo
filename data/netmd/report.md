# netmd CWL Generation Report

## netmd

### Tool Description
Parser testing

### Metadata
- **Docker Image**: quay.io/biocontainers/netmd:1.0.3--pyh3c853c9_0
- **Homepage**: https://github.com/mazzalab/NetMD
- **Package**: https://anaconda.org/channels/bioconda/packages/netmd/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/netmd/overview
- **Total Downloads**: 286
- **Last updated**: 2025-10-12
- **GitHub**: https://github.com/mazzalab/NetMD
- **Stars**: N/A
### Original Help Text
```text
usage: [32mpython3 [37mmain.py[35m [-h] [-v] ( -i INPUTPATH INPUTPATH | -f [FILES ...]) [-e EDGEFILTER] [-o OUTPUTPATH] [-c CONFIGFILE][0m

[37m[1m Parser testing [0m

[36m[1mArguments[0m:
  -h, --help            show this help message and exit
  -I INPUTPATH INPUTPATH, --InputPath INPUTPATH INPUTPATH
                        -[required] Specify the directory tree path followed
                        by the standardized prefix of the contacts file name.
                        Example: -i examples_dir contacts.tsv
  -F FILES [FILES ...], --Files FILES [FILES ...]
                        -[required] Specify one or more contact file paths.
  -f FEATURES, --features FEATURES
                        -[optional] Specify the path to the input file
                        containing node features. If provided, the file must
                        be in tab-separated values (TSV) format. If no path is
                        provided, the unique chain identifier of each residue
                        in the contacts file will be used as the node feature
  -e EDGEFILTER, --edgeFilter EDGEFILTER
                        -[optional] Specify the entropy threshold used to
                        filter the graph edges. (default 0.1)
  -c CONFIGFILE, --configFile CONFIGFILE
                        -[optional] Specify the path to the configuration file
                        containing arguments for Graph2Vec. If no path is
                        provided, default values will be used.
  -o OUTPUTPATH, --outputPath OUTPUTPATH
                        -[optional] Specify the output path. If no path is
                        provided, the "results" folder will be used.
  -p {svg,png}, --plotFormat {svg,png}
                        -[optional] Specify the format of the image output.
                        (svg or png; default: svg)
  --verbose             Allow extra prints.
```

