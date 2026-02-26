# sequenza-utils CWL Generation Report

## sequenza-utils_bam2seqz

### Tool Description
Convert BAM files to Sequenza's .seqz format.

### Metadata
- **Docker Image**: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
- **Homepage**: http://sequenza-utils.readthedocs.org
- **Package**: https://anaconda.org/channels/bioconda/packages/sequenza-utils/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/sequenza-utils/overview
- **Total Downloads**: 24.2K
- **Last updated**: 2025-04-22
- **GitHub**: N/A
- **Stars**: N/A
### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/sequenza-utils", line 11, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.11/site-packages/sequenza/commands.py", line 39, in main
    modules[args.module](subparsers, args.module, extra, log)
  File "/usr/local/lib/python3.11/site-packages/sequenza/programs/bam2seqz.py", line 113, in bam2seqz
    args = bam2seqz_args(add_parser(subparsers, module_name), argv)
                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/sequenza/programs/bam2seqz.py", line 12, in add_parser
    return subparsers.add_parser(
           ^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/argparse.py", line 1197, in add_parser
    raise ArgumentError(self, _('conflicting subparser: %s') % name)
argparse.ArgumentError: argument module: conflicting subparser: bam2seqz
```


## sequenza-utils_gc_wiggle

### Tool Description
Generates a wiggle file with GC content information for each bin.

### Metadata
- **Docker Image**: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
- **Homepage**: http://sequenza-utils.readthedocs.org
- **Package**: https://anaconda.org/channels/bioconda/packages/sequenza-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/sequenza-utils", line 11, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.11/site-packages/sequenza/commands.py", line 39, in main
    modules[args.module](subparsers, args.module, extra, log)
  File "/usr/local/lib/python3.11/site-packages/sequenza/programs/gc_wiggle.py", line 28, in gc_wiggle
    args = gc_wiggle_args(add_parser(subparsers, module_name), argv)
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/sequenza/programs/gc_wiggle.py", line 7, in add_parser
    return subparsers.add_parser(
           ^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/argparse.py", line 1197, in add_parser
    raise ArgumentError(self, _('conflicting subparser: %s') % name)
argparse.ArgumentError: argument module: conflicting subparser: gc_wiggle
```


## sequenza-utils_pileup2acgt

### Tool Description
Converts a pileup file to ACGT format.

### Metadata
- **Docker Image**: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
- **Homepage**: http://sequenza-utils.readthedocs.org
- **Package**: https://anaconda.org/channels/bioconda/packages/sequenza-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/sequenza-utils", line 11, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.11/site-packages/sequenza/commands.py", line 39, in main
    modules[args.module](subparsers, args.module, extra, log)
  File "/usr/local/lib/python3.11/site-packages/sequenza/programs/pileup2acgt.py", line 61, in pileup2acgt
    args = pileup2actg_args(add_parser(subparsers, module_name), argv)
                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/sequenza/programs/pileup2acgt.py", line 14, in add_parser
    return subparsers.add_parser(module_name, add_help=False,
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/argparse.py", line 1197, in add_parser
    raise ArgumentError(self, _('conflicting subparser: %s') % name)
argparse.ArgumentError: argument module: conflicting subparser: pileup2acgt
```


## sequenza-utils_seqz_binning

### Tool Description
Binning of the genome based on allele frequencies.

### Metadata
- **Docker Image**: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
- **Homepage**: http://sequenza-utils.readthedocs.org
- **Package**: https://anaconda.org/channels/bioconda/packages/sequenza-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/sequenza-utils", line 11, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.11/site-packages/sequenza/commands.py", line 39, in main
    modules[args.module](subparsers, args.module, extra, log)
  File "/usr/local/lib/python3.11/site-packages/sequenza/programs/seqz_binning.py", line 31, in seqz_binning
    args = binning_args(add_parser(subparsers, module_name), argv)
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/sequenza/programs/seqz_binning.py", line 7, in add_parser
    return subparsers.add_parser(
           ^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/argparse.py", line 1197, in add_parser
    raise ArgumentError(self, _('conflicting subparser: %s') % name)
argparse.ArgumentError: argument module: conflicting subparser: seqz_binning
```


## sequenza-utils_seqz_merge

### Tool Description
Merge multiple Sequenza .seqz files into a single file.

### Metadata
- **Docker Image**: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
- **Homepage**: http://sequenza-utils.readthedocs.org
- **Package**: https://anaconda.org/channels/bioconda/packages/sequenza-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/sequenza-utils", line 11, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.11/site-packages/sequenza/commands.py", line 39, in main
    modules[args.module](subparsers, args.module, extra, log)
  File "/usr/local/lib/python3.11/site-packages/sequenza/programs/seqz_merge.py", line 43, in seqz_merge
    subp = add_parser(subparsers, module_name)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/sequenza/programs/seqz_merge.py", line 7, in add_parser
    return subparsers.add_parser(module_name, add_help=False,
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/argparse.py", line 1197, in add_parser
    raise ArgumentError(self, _('conflicting subparser: %s') % name)
argparse.ArgumentError: argument module: conflicting subparser: seqz_merge
```


## sequenza-utils_snp2seqz

### Tool Description
Convert SNP-calling results to seqz format

### Metadata
- **Docker Image**: quay.io/biocontainers/sequenza-utils:3.0.0--py311h8ddd9a4_8
- **Homepage**: http://sequenza-utils.readthedocs.org
- **Package**: https://anaconda.org/channels/bioconda/packages/sequenza-utils/overview
- **Validation**: PASS

### Original Help Text
```text
Traceback (most recent call last):
  File "/usr/local/bin/sequenza-utils", line 11, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.11/site-packages/sequenza/commands.py", line 39, in main
    modules[args.module](subparsers, args.module, extra, log)
  File "/usr/local/lib/python3.11/site-packages/sequenza/programs/snp2seqz.py", line 85, in snp2seqz
    subp = add_parser(subparsers, module_name)
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/site-packages/sequenza/programs/snp2seqz.py", line 8, in add_parser
    return subparsers.add_parser(module_name, add_help=False,
           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/argparse.py", line 1197, in add_parser
    raise ArgumentError(self, _('conflicting subparser: %s') % name)
argparse.ArgumentError: argument module: conflicting subparser: snp2seqz
```

