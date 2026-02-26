# scanindel CWL Generation Report

## scanindel_ScanIndel.py

### Tool Description
ScanIndel is a tool for indel calling.

### Metadata
- **Docker Image**: quay.io/biocontainers/scanindel:1.3--py27_0
- **Homepage**: https://github.com/cauyrd/ScanIndel
- **Package**: https://anaconda.org/channels/bioconda/packages/scanindel/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/scanindel/overview
- **Total Downloads**: 5.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/cauyrd/ScanIndel
- **Stars**: N/A
### Original Help Text
```text
option --h not a unique prefix
Usage:
 python ScanIndel.py -p config.txt -i sample.txt [opts]
Opts:
 -o  :setting the output directory (default current working directory)
 -F  :setting min-alternate-fraction for FreeBayes (default 0.2)
 -C  :setting min-alternate-count for FreeBayes (default 2)
 -d  :setting min-coverage for Freebayes (default 0)
 -t  :setting --target for Freebayes to provide a BED file for analysis
 -s  :softclipping percentage triggering BLAT re-alignment (default 0.2)
 --min_percent_hq  :min percentage of high quality base in soft clipping reads, default 0.8
 --lowqual_cutoff  :low quality cutoff value, default 20
 --mapq_cutoff  :low mapping quality cutoff, default 1
 --blat_ident_pct_cutoff  :Blat sequence identity cutoff, default 0.8
 --gfServer_port  :gfServer service port number, default 50000
 --hetero_factor  :The factor about the indel's heterogenirity and heterozygosity, default 0.1
 --bam  :the input file is BAM format
 --rmdup  :exccute duplicate removal step before realignment
 --assembly_only  :only execute de novo assembly for indel calling without blat realignment (default False)
 --mapping_only  :only execute blat realignment withou de novo assembly for indel calling (default False)
 -h --help :produce this menu
 -v --version :show version of this tool
author: Rendong Yang <yang4414@umn.edu>, MSI, University of Minnesota, 2014
version: 1.3
```

