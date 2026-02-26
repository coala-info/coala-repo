# hichipper CWL Generation Report

## hichipper_call

### Tool Description
a preprocessing and QC pipeline for HiChIP data.

### Metadata
- **Docker Image**: quay.io/biocontainers/hichipper:0.7.7--py_0
- **Homepage**: https://github.com/aryeelab/hichipper
- **Package**: https://anaconda.org/channels/bioconda/packages/hichipper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/hichipper/overview
- **Total Downloads**: 8.0K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/aryeelab/hichipper
- **Stars**: N/A
### Original Help Text
```text
Usage: hichipper [OPTIONS] MODE

  hichipper: a preprocessing and QC pipeline for HiChIP data.

  (c) Aryee Lab, 2019

  See https://hichipper.readthedocs.io for more details.

  hichipper mode: [call, *.yaml] ^ either specify the word `call` and feed
  in a valid interactions file OR specify the .yaml format for options to be
  parsed from a manifest file (see documentation)

Options:
  --version                      Show the version and exit.
  -o, --out TEXT                 Output directory name; must not be already
                                 existing [Required]  [required]
  -z, --keep-temp-files          Keep temporary files?
  -ii, --input-vi TEXT           Comma-separted list of interactions files for
                                 loop calling; option valid only in `call`
                                 mode
  -rf, --restriction-frags TEXT  Filepath to restriction fragment files; will
                                 overwrite specification of this file when a
                                 .yaml is supplied for mode
  -p, --peaks TEXT               Either 1 of 4 peak logic strings or a valid
                                 filepath to a .bed (or similary formatted)
                                 file; defers to what is in the .yaml
  -k, --keep-samples TEXT        Comma separated list of sample names to keep;
                                 ALL (special string) by default
  -x, --ignore-samples TEXT      Comma separated list of sample names to
                                 ignore; NONE (special string) by default
  -l, --read-length TEXT         Length of reads from sequencing runs; default
                                 = 75
  -mi, --min-dist TEXT           Minimum distance for loop calls; default =
                                 5000
  -ma, --max-dist TEXT           Maximum distance for loop calls; default =
                                 2000000
  --macs2-string TEXT            String of arguments to pass to MACS2; only is
                                 called when peaks are set to be called;
                                 default = "-q 0.01 --extsize 147 --nomodel"
  --macs2-genome TEXT            Argument to pass to the -g variable in MACS2
                                 (mm for mouse genome; hs for human genome);
                                 default = "hs"
  -pp, --peak-pad TEXT           Peak padding width (applied on both left and
                                 right); default = 500
  -mg, --merge-gap TEXT          Merge nearby peaks (after all padding is
                                 complete; default = 500
  -nm, --no-merge                Completely skip anchor merging; will affect
                                 summary statistics. Not recommended unless
                                 understood what is happening.
  --skip-resfrag-pad             Skip restriction fragment aware padding
  --skip-background-correction   Skip restriction fragment aware background
                                 correction?
  -mu, --make-ucsc               Make additional output files that can support
                                 viewing in UCSC genome browser; requires
                                 tabix and bgzip; does the same thing as
                                 --make-washu.
  -mw, --make-washu              Make additional output files that can support
                                 viewing in WashU genome browser; requires
                                 tabix and bgzip; does the same thing as
                                 --make-ucsc.
  --basic-qc                     Create a simple QC report without Pandoc
  --skip-diffloop                Skip analyses in diffloop (e.g. Mango loop
                                 calling; .rds generation)
  --bedtools-path TEXT           Path to bedtools; by default, assumes that
                                 bedtools is in PATH
  --macs2-path TEXT              Path to macs2; by default, assumes that macs2
                                 is in PATH
  --tabix-path TEXT              Path to samtools; by default, assumes that
                                 tabix is in PATH
  --bgzip-path TEXT              Path to macs2; by default, assumes that bgzip
                                 is in PATH
  --r-path TEXT                  Path to R; by default, assumes that R is in
                                 PATH
  --help                         Show this message and exit.
```

