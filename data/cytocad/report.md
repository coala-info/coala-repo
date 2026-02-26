# cytocad CWL Generation Report

## cytocad

### Tool Description
CytoCAD is a tool for discovering large genomic copy-number variation through coverage anormaly detection (CAD) using low-depth whole-genome sequencing data.

### Metadata
- **Docker Image**: quay.io/biocontainers/cytocad:1.0.3--py310h4b81fae_2
- **Homepage**: https://github.com/cytham/cytocad
- **Package**: https://anaconda.org/channels/bioconda/packages/cytocad/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/cytocad/overview
- **Total Downloads**: 10.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cytham/cytocad
- **Stars**: N/A
### Original Help Text
```text
usage: cytocad [options] [BAM] [WORK_DIRECTORY]

CytoCAD is a tool for discovering large genomic copy-number variation through coverage anormaly detection (CAD) using low-depth whole-genome sequencing data.

positional arguments:
  [BAM]                 path to mapped BAM file.
                        Format: .bam
  [work_directory]      path to work directory. Directory will be created 
                        if it does not exist.

options:
  -h, --help            show this help message and exit
  -b str, --build str   build version of human reference genome assembly [hg38]
  -c hex_color [hex_color ...], --colors hex_color [hex_color ...]
                        hex color for neutral, gain, and loss CNVs on chromosome
                        ideograms respectively separated by space ['#a6a6a6' '#990000' '#000099']
  -f [png/pdf], --format [png/pdf]
                        Output format of chromosome illustration figure [png]
  -i int, --interval int
                        spread between each point in a chromosome where "
                        coverage is enquired, in bp. Minimum CNV sensitive 
                        detection size ~= interval*rolling [50000]
  -j int, --buffer int  buffer window size of each point, in bp [10]
  -r int, --rolling int
                        rolling mean window size [10]
  -p int, --penalty int
                        Linear kernel penalty value for change 
                        point detection using Ruptures [500]
  -s float, --scale float
                        proportion of mean coverage to be used for 
                        buffering to call hetero- and homozygous CNVs 
                        (E.g. a heterozygous loss is where a coverage (c) 
                        satisfies: mean-mean*scale <= c < mean+mean*scale [0.25]
  --add_plots           output additional coverage plots in 'fig' directory
  --debug               run in debug mode
  -v, --version         show version and exit
  -q, --quiet           hide verbose
```

