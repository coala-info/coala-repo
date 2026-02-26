# kleborate CWL Generation Report

## kleborate

### Tool Description
Kleborate: a tool for characterising virulence and resistance in pathogen assemblies

### Metadata
- **Docker Image**: quay.io/biocontainers/kleborate:3.2.4--pyhdfd78af_0
- **Homepage**: https://github.com/katholt/Kleborate
- **Package**: https://anaconda.org/channels/bioconda/packages/kleborate/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/kleborate/overview
- **Total Downloads**: 39.3K
- **Last updated**: 2025-07-15
- **GitHub**: https://github.com/katholt/Kleborate
- **Stars**: N/A
### Original Help Text
```text
tput: No value for $TERM and no -T specified
usage: kleborate [-a ASSEMBLIES [ASSEMBLIES ...]] [-o OUTDIR] [-r]
                 [--trim_headers] [--list_modules] [-p PRESET] [-m MODULES]
                 [-h] [--help_all] [--version]

Kleborate: a tool for characterising virulence and resistance in pathogen
assemblies

Input/output:
  -a, --assemblies ASSEMBLIES [ASSEMBLIES ...]
                          FASTA file(s) for assemblies
  -o, --outdir OUTDIR     Directory for storing output files
  -r, --resume            append the output files (default: False)
  --trim_headers          Trim headers in the output files (default: False)

Modules:
  --list_modules          Print a list of all available modules and then quit
                          (default: False)
  -p, --preset PRESET     Module presets, choose from: kpsc, kosc, escherichia
  -m, --modules MODULES   Comma-delimited list of Kleborate modules to use

Help:
  -h, --help              Show this help message and exit
  --help_all              Show a help message with all module options
  --version               Show program's version number and exit

If you use Kleborate, please cite the paper:
Lam MMC, et al. A genomic surveillance framework and genotyping tool for
Klebsiella pneumoniae and its related species complex. Nature Communications.
2021. doi:10.1038/s41467-021-24448-3.

If you turn on the Kaptive option for full K and O typing, please also cite:
Wyres KL, et al. Identification of Klebsiella capsule synthesis loci from whole
genome data. Microbial Genomics. 2016. doi:10.1099/mgen.0.000102.
```

