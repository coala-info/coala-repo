# ucsc-hggcpercent CWL Generation Report

## ucsc-hggcpercent_hgGcPercent

### Tool Description
Calculate GC Percentage in 20kb windows

### Metadata
- **Docker Image**: quay.io/biocontainers/ucsc-hggcpercent:482--h0b57e2e_0
- **Homepage**: https://hgdownload.cse.ucsc.edu/admin/exe
- **Package**: https://anaconda.org/channels/bioconda/packages/ucsc-hggcpercent/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/ucsc-hggcpercent/overview
- **Total Downloads**: 58.7K
- **Last updated**: 2025-06-26
- **GitHub**: https://github.com/ucscGenomeBrowser/kent
- **Stars**: N/A
### Original Help Text
```text
hgGcPercent - Calculate GC Percentage in 20kb windows
usage:
   hgGcPercent [options] database nibDir
     nibDir can be a .2bit file, a directory that contains a
     database.2bit file, or a directory that contains *.nib files.
     Loads gcPercent table with counts from sequence.
options:
   -win=<size> - change windows size (default 20000)
   -noLoad - do not load mysql table - create bed file
   -file=<filename> - output to <filename> (stdout OK) (implies -noLoad)
   -chr=<chrN> - process only chrN from the nibDir
   -noRandom - ignore randome chromosomes from the nibDir
   -noDots - do not display ... progress during processing
   -doGaps - process gaps correctly (default: gaps are not counted as GC)
   -wigOut - output wiggle ascii data ready to pipe to wigEncode
   -overlap=N - overlap windows by N bases (default 0)
   -verbose=N - display details to stderr during processing
   -bedRegionIn=input.bed   Read in a bed file for GC content in specific regions and write to bedRegionsOut
   -bedRegionOut=output.bed Write a bed file of GC content in specific regions from bedRegionIn

example:
  calculate GC percent in 5 base windows using a 2bit assembly (dp2):
    hgGcPercent -wigOut -doGaps -win=5 -file=stdout -verbose=0 \
      dp2 /cluster/data/dp2 \
    | wigEncode stdin gc5Base.wig gc5Base.wib
```

