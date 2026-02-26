# iqkm CWL Generation Report

## iqkm

### Tool Description
Workflow for KM assignment and/or quantification, on both contig and sample basis

### Metadata
- **Docker Image**: quay.io/biocontainers/iqkm:1.0--pyhdfd78af_0
- **Homepage**: https://github.com/lijingdi/iqKM
- **Package**: https://anaconda.org/channels/bioconda/packages/iqkm/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/iqkm/overview
- **Total Downloads**: 2.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/lijingdi/iqKM
- **Stars**: N/A
### Original Help Text
```text
usage: iqkm -i metagenome -o out_dir --help_dir help_dir --fq fastq1 --rq fastq2 --meta --quantify

Workflow for KM assignment and/or quantification, on both contig and sample
basis

required arguments:
  -i GENOME, --input GENOME
                        Input genome/metagenomes, required
  -o OUTDIR, --out_dir OUTDIR
                        Output folder
  --help_dir HELP_DIR   Folder containing Kofam HMM database and help files,
                        refer to README.md for downloading

optional arguments:
  --fq FASTQ1           Input first or only read file (fastq or fastq.gz),
                        required when '--quantify' is specified
  -h, --help
  --rq FASTQ2           Input reverse read (fastq or fastq.gz format),
                        optional
  --prefix PREFIX       Prefix of output files, default: your input
                        genome/metagenome file name without postfix
  --db HMMDB            Kofam HMM database for KO assignment, default
                        path='/help_dir/db/kofam.hmm', you can change it to
                        your customised db
  --com COM             KM completeness threshold on contig basis (only KM
                        with completeness above the threshold will be
                        considered present), default = 66.67
  --skip                Force skip steps if relevant output files have been
                        found under designated directories, not recommanded if
                        your input file is newer (default = False)
  -q, --quantify        Run both KM assignment and quantification (default =
                        False, add '-q' or '--quantify' to enable)
  -m, --meta            Running in metagenome mode (prodigal -p meta; default
                        = False)
  -w INCLUDE_WEIGHTS, --include_weights INCLUDE_WEIGHTS
                        Include weights of each KO when doing KM assignment
                        (default = True)
  -n CPU, --threads CPU
                        Number of threads used for computation (default = 1)
  -f, --force           Force reruning the whole pipeline, don't resume
                        previous run (default = False)
  -d, --dist            Apply KM minimum distance threshold (default = True)
  -g GE, --genome_equivalent GE
                        Genome equivalent output generated from microbe-
                        census, can be used for library-size normalization
                        when doing quantification. Optional (default: None)
```

