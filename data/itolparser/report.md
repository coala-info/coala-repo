# itolparser CWL Generation Report

## itolparser

### Tool Description
Generate iTOL files from tables

### Metadata
- **Docker Image**: quay.io/biocontainers/itolparser:0.2.1--pyh7cba7a3_0
- **Homepage**: https://github.com/boasvdp/itolparser
- **Package**: https://anaconda.org/channels/bioconda/packages/itolparser/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/itolparser/overview
- **Total Downloads**: 5.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/boasvdp/itolparser
- **Stars**: N/A
### Original Help Text
```text
usage: itolparser [-h] -i INPUT [-o OUTDIR] [--tsv] [--csv] [-v]
                  [--margin INT] [--stripwidth INT] [--maxcategories INT]
                  [--ignore IGNORE [IGNORE ...]]
                  [--continuous CONTINUOUS [CONTINUOUS ...]]
                  [--palette {YlGn,YlGnBu,GnBu,BuGn,PuBuGn,PuBu,BuPu,RdPu,PuRd,OrRd,YlOrRd,YlOrBr,Purples,Blues,Greens,Oranges,Reds,Greys}]

Generate iTOL files from tables

options:
  -h, --help            show this help message and exit

Main arguments:
  -i INPUT, --input INPUT
                        Input table with categorical metadata in .tsv format
                        unless otherwise specified (default: None)
  -o OUTDIR, --outdir OUTDIR
                        Output directory to write files to (default:
                        itolparser_output)
  --tsv                 Force input parsing as .tsv file (default: False)
  --csv                 Force input parsing as .csv file (default: False)
  -v, --version         prints program version and exits

Formatting arguments:
  --margin INT          Size of margin specified in iTOL file (default: 5)
  --stripwidth INT      Strip width specified in iTOL file (default: 50)
  --maxcategories INT   Maximum number of categories to not get assigned to
                        "other" (default: 18)
  --ignore IGNORE [IGNORE ...]
                        List of columns to ignore (default: None)
  --continuous CONTINUOUS [CONTINUOUS ...]
                        Comma-separated list of columns to parse as continuous
                        (default: None)
  --palette {YlGn,YlGnBu,GnBu,BuGn,PuBuGn,PuBu,BuPu,RdPu,PuRd,OrRd,YlOrRd,YlOrBr,Purples,Blues,Greens,Oranges,Reds,Greys}
                        Color palette to use for continuous columns (default:
                        GnBu)
```

