# stecfinder CWL Generation Report

## stecfinder

### Tool Description
STECFinder.py is a tool for identifying Shiga toxin-producing E. coli (STEC) strains.

### Metadata
- **Docker Image**: quay.io/biocontainers/stecfinder:1.1.2--pyhdfd78af_0
- **Homepage**: https://github.com/LanLab/STECFinder
- **Package**: https://anaconda.org/channels/bioconda/packages/stecfinder/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/stecfinder/overview
- **Total Downloads**: 7.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/LanLab/STECFinder
- **Stars**: N/A
### Original Help Text
```text
usage: 
STECFinder.py -i <input_data1> <input_data2> ... OR
STECFinder.py -i <directory/*> OR 
STECFinder.py -i <Read1> <Read2> -r [Raw Reads]

Input/Output:
  -i I [I ...]          <string>: path/to/input_data (default: None)
  -r                    Add flag if file is raw reads. (default: False)
  --sample_sheet SAMPLE_SHEET
                        Specify input via sample sheet. Sample sheet should be
                        CSV with columns 'read_1,read_2,unpaired'. (default:
                        None)
  -t T                  number of threads. Default 4. (default: 4)
  --hits                shows detailed gene search results (default: False)
  --output OUTPUT       output file to write to (if not used writes to stdout
                        and tmp folder in current dir) (default: None)

Misc:
  -h, --help            show this help message and exit
  --check               check dependencies are installed (default: False)
  -v, --version         Print version number (default: False)

Algorithm cutoffs:
  --cutoff CUTOFF       minimum read coverage for gene to be called (default:
                        10.0)
  --length LENGTH       percentage of gene length needed for positive call
                        (default: 50.0)
  --ipaH_length IPAH_LENGTH
                        percentage of ipaH gene length needed for positive
                        gene call (default: 10.0)
  --ipaH_depth IPAH_DEPTH
                        When using reads as input the minimum depth percentage
                        relative to genome average for positive ipaH gene call
                        (default: 1.0)
  --stx_length STX_LENGTH
                        percentage of stx gene length needed for positive gene
                        call (default: 10.0)
  --stx_depth STX_DEPTH
                        When using reads as input the minimum depth percentage
                        relative to genome average for positive stx gene call
                        (default: 1.0)
  --o_length O_LENGTH   percentage of wz_ gene length needed for positive call
                        (default: 60.0)
  --o_depth O_DEPTH     When using reads as input the minimum depth percentage
                        relative to genome average for positive wz_ gene call
                        (default: 1.0)
  --h_length H_LENGTH   percentage of fliC gene length needed for positive
                        call (default: 60.0)
  --h_depth H_DEPTH     When using reads as input the minimum depth percentage
                        relative to genome average for positive fliC gene call
                        (default: 1.0)
stecfinder: error: ambiguous option: --h could match --hits, --help, --h_length, --h_depth
```

