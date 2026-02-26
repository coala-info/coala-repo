# novasplice CWL Generation Report

## novasplice

### Tool Description
NovaSplice is a tool for identifying novel splice sites.

### Metadata
- **Docker Image**: quay.io/biocontainers/novasplice:0.0.4--py_0
- **Homepage**: https://github.com/aryakaul/novasplice
- **Package**: https://anaconda.org/channels/bioconda/packages/novasplice/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/novasplice/overview
- **Total Downloads**: 6.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/aryakaul/novasplice
- **Stars**: N/A
### Original Help Text
```text
usage: novasplice [-h] [-v VCF] [-vz ZIPPEDVCF] [-r REFERENCE]
                  [-rz ZIPPEDREFERENCE] -b BED -c CHRLENS [-p PERCENT]
                  [-o OUTPUT] [-i INTERMEDIATE] [-t TEMP] [-l LIBRARYNAME]

optional arguments:
  -h, --help            show this help message and exit
  -v VCF, --vcf VCF     Full path to the sorted vcf file being used
  -vz ZIPPEDVCF, --zippedvcf ZIPPEDVCF
                        Full path to the sorted zipped vcf file being used
  -r REFERENCE, --reference REFERENCE
                        Full path to the reference genome being used
  -rz ZIPPEDREFERENCE, --zippedreference ZIPPEDREFERENCE
                        Full path to the zipped reference genome being used
  -b BED, --bed BED     Full path to the reference exon boundary bed file
                        being used
  -c CHRLENS, --chrlens CHRLENS
                        Full path to the chromosome length file being used
  -p PERCENT, --percent PERCENT
                        Lower bound percent to call novel splice site
  -o OUTPUT, --output OUTPUT
                        Path to the output folder to dump simdigree's output
                        to. Default is working directory under
                        /novasplice_output
  -i INTERMEDIATE, --intermediate INTERMEDIATE
                        Path to output folder that will hold intermediate
                        files generated, not specific to the provided vcf.
                        Especially useful when running NovaSplice on a large
                        number of VCFs that all come from the same reference
                        and make use of the same --bed option.
  -t TEMP, --temp TEMP  Full path to an alternative directory to use for temp
                        files. Default is /tmp
  -l LIBRARYNAME, --libraryname LIBRARYNAME
                        Name of the final file novasplice outputs with
                        predictions
```

