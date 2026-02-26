# wgfast CWL Generation Report

## wgfast

### Tool Description
Must provide reference_dir.

### Metadata
- **Docker Image**: quay.io/biocontainers/wgfast:1.0.4--py_0
- **Homepage**: https://github.com/jasonsahl/wgfast
- **Package**: https://anaconda.org/channels/bioconda/packages/wgfast/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/wgfast/overview
- **Total Downloads**: 8.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/jasonsahl/wgfast
- **Stars**: N/A
### Original Help Text
```text
Must provide reference_dir.

Usage: wgfast [options]

Options:
  -h, --help            show this help message and exit
  -r REFERENCE_DIR, --reference_directory=REFERENCE_DIR
                        path to reference file directory [REQUIRED]
  -d READ_DIRECTORY, --read_directory=READ_DIRECTORY
                        path to directory of fastq files [REQUIRED]
  -p PROCESSORS, --processors=PROCESSORS
                        # of processors to use - defaults to 2
  -c COVERAGE, --coverage=COVERAGE
                        minimum SNP coverage required to be called a SNP -
                        defaults to 3
  -o PROPORTION, --proportion=PROPORTION
                        proportion of alleles to be called a SNP, defaults to
                        0.9
  -k KEEP, --keep=KEEP  keep temp files?  Defaults to F
  -s SUBSAMPLE, --subsample=SUBSAMPLE
                        Run subsample routine? Defaults to T
  -n SUBNUMS, --subnums=SUBNUMS
                        number of subsamples to process, defaults to 100
  -g DOC, --doc=DOC     run depth of coverage on all files?  Defaults to T
  -e TMP_DIR, --temp=TMP_DIR
                        temporary directory for GATK analysis, defaults to
                        /tmp
  -f FUDGE, --fudge_factor=FUDGE
                        How close does a subsample have to be from true
                        placement?  Defaults to 0.1
  -y ONLY_SUBS, --only_subs=ONLY_SUBS
                        Only run sub-sample routine and exit? Defaults to F
  -j MODEL, --model=MODEL
                        which model to run with raxml, GTRGAMMA, ASC_GTRGAMMA,
                        GTRCAT, ASC_GTRCAT
  -q GATK_METHOD, --gatk_method=GATK_METHOD
                        How to call GATK? Defaults to
                        EMIT_ALL_CONFIDENT_SITES, can be EMIT_ALL_SITES
```


## Metadata
- **Skill**: generated
