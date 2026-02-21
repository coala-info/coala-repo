# fithic CWL Generation Report

## fithic

### Tool Description
Calculate statistical significance of Hi-C interactions

### Metadata
- **Docker Image**: quay.io/biocontainers/fithic:2.0.8--pyhdfd78af_1
- **Homepage**: https://github.com/ay-lab/fithic/tree/master
- **Package**: https://anaconda.org/channels/bioconda/packages/fithic/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/fithic/overview
- **Total Downloads**: 12.5K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/ay-lab/fithic
- **Stars**: N/A
### Original Help Text
```text
usage: fithic [-h] -i INTERSFILE -f FRAGSFILE -o OUTDIR -r RESOLUTION
              [-t BIASFILE] [-p NOOFPASSES] [-b NOOFBINS]
              [-m MAPPABILITYTHRESHOLD] [-l LIBNAME] [-U DISTUPTHRES]
              [-L DISTLOWTHRES] [-v] [-x CONTACTTYPE] [-tL BIASLOWERBOUND]
              [-tU BIASUPPERBOUND] [-V]

Check the help flag

options:
  -h, --help            show this help message and exit
  -i INTERSFILE, --interactions INTERSFILE
                        REQUIRED: interactions between fragment pairs are read
                        from INTERSFILE
  -f FRAGSFILE, --fragments FRAGSFILE
                        REQUIRED: midpoints (or start indices) of the
                        fragments are read from FRAGSFILE
  -o OUTDIR, --outdir OUTDIR
                        REQUIRED: where the output files will be written
  -r RESOLUTION, --resolution RESOLUTION
                        REQUIRED: If the files are fixed size, please supply
                        the resolution of the dataset here; otherwise, please
                        use a value of 0 if the data is not fixed size.
  -t BIASFILE, --biases BIASFILE
                        RECOMMENDED: biases calculated by ICE or KR norm for
                        each locus are read from BIASFILE
  -p NOOFPASSES, --passes NOOFPASSES
                        OPTIONAL: number of spline passes to run Default is 1
  -b NOOFBINS, --noOfBins NOOFBINS
                        OPTIONAL: number of equal-occupancy (count) bins.
                        Default is 100
  -m MAPPABILITYTHRESHOLD, --mappabilityThres MAPPABILITYTHRESHOLD
                        OPTIONAL: minimum number of hits per locus that has to
                        exist to call it mappable. DEFAULT is 1.
  -l LIBNAME, --lib LIBNAME
                        OPTIONAL: Name of the library that is analyzed to be
                        used for name of file prefixes . DEFAULT is fithic
  -U DISTUPTHRES, --upperbound DISTUPTHRES
                        OPTIONAL: upper bound on the intra-chromosomal
                        distance range (unit: base pairs). DEFAULT no limit.
                        STRONGLY suggested to have a limit for large genomes,
                        such as human/mouse. ex. '1000000, 5000000, etc.'
  -L DISTLOWTHRES, --lowerbound DISTLOWTHRES
                        OPTIONAL: lower bound on the intra-chromosomal
                        distance range (unit: base pairs). DEFAULT no limit.
                        Suggested limit is 2x the resolution of the input
                        files
  -v, --visual          OPTIONAL: use this flag for generating plots. DEFAULT
                        is False.
  -x CONTACTTYPE, --contactType CONTACTTYPE
                        OPTIONAL: use this flag to determine which chromosomal
                        regions to study (intraOnly, interOnly, All) DEFAULT
                        is intraOnly
  -tL BIASLOWERBOUND, --biasLowerBound BIASLOWERBOUND
                        OPTIONAL: this flag is used to determine the lower
                        bound of bias values to discard. DEFAULT is 0.5
  -tU BIASUPPERBOUND, --biasUpperBound BIASUPPERBOUND
                        OPTIONAL: this flag is used to determine the upper
                        bound of bias values to discard. DEFAULT is 2
  -V, --version         Print version and exit
```


## Metadata
- **Skill**: generated
