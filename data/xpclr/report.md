# xpclr CWL Generation Report

## xpclr

### Tool Description
Tool to calculate XP-CLR as per Chen, Patterson, Reich 2010

### Metadata
- **Docker Image**: quay.io/biocontainers/xpclr:1.1.2--py_0
- **Homepage**: https://github.com/hardingnj/xpclr
- **Package**: https://anaconda.org/channels/bioconda/packages/xpclr/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/xpclr/overview
- **Total Downloads**: 9.7K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/hardingnj/xpclr
- **Stars**: N/A
### Original Help Text
```text
usage: xpclr [-h] --out OUT [--format FORMAT] [--input INPUT]
             [--gdistkey GDISTKEY] [--samplesA SAMPLESA] [--samplesB SAMPLESB]
             [--rrate RRATE] [--map MAP] [--popA POPA] [--popB POPB] --chr
             CHROM [--ld LDCUTOFF] [--phased] [--verbose VERBOSE]
             [--maxsnps MAXSNPS] [--minsnps MINSNPS] [--size SIZE]
             [--start START] [--stop STOP] [--step STEP]

Tool to calculate XP-CLR as per Chen, Patterson, Reich 2010

optional arguments:
  -h, --help            show this help message and exit
  --out OUT, -O OUT     output file
  --format FORMAT, -F FORMAT
                        input expected. One of "vcf" (default), "hdf5", "zarr"
                        or "txt"
  --input INPUT, -I INPUT
                        input file vcf or hdf5
  --gdistkey GDISTKEY   key for genetic position in variants table of hdf5/VCF
  --samplesA SAMPLESA, -Sa SAMPLESA
                        Samples comprising population A. Comma separated list
                        or path to file with each ID on a line
  --samplesB SAMPLESB, -Sb SAMPLESB
                        Samples comprising population B. Comma separated list
                        or path to file with each ID on a line
  --rrate RRATE, -R RRATE
                        recombination rate per base
  --map MAP             If using XPCLR-style text format. Input map file as
                        per XPCLR specs (tab separated)
  --popA POPA           If using XPCLR-style text format. Filepath to
                        population A genotypes (space separated)
  --popB POPB           If using XPCLR-style text format. Filepath to
                        population B genotypes (space separated)
  --chr CHROM, -C CHROM
                        Which contig analysis is based on
  --ld LDCUTOFF, -L LDCUTOFF
                        LD cutoff to apply for weighting
  --phased, -P          whether data is phased for more precise r2 calculation
  --verbose VERBOSE, -V VERBOSE
                        How verbose to be in logging. 10=DEBUG, 20=INFO,
                        30=WARN, 40=ERROR, 50=CRITICAL
  --maxsnps MAXSNPS, -M MAXSNPS
                        max SNPs in a window
  --minsnps MINSNPS, -N MINSNPS
                        min SNPs in a window
  --size SIZE           window size in base pairs
  --start START         start base position for windows
  --stop STOP           stop base position for windows
  --step STEP           step size for sliding windows
```

