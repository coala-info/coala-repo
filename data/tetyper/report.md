# tetyper CWL Generation Report

## tetyper_TETyper.py

### Tool Description
Given a set of input reads and a reference, TETyper performs typing to identify: 1. deletions and SNP variation relative to the reference, and 2. the immediate (up to ~20bp) sequence(s) flanking the reference.

### Metadata
- **Docker Image**: quay.io/biocontainers/tetyper:1.1--0
- **Homepage**: https://github.com/aesheppard/TETyper
- **Package**: https://anaconda.org/channels/bioconda/packages/tetyper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/tetyper/overview
- **Total Downloads**: 3.3K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/aesheppard/TETyper
- **Stars**: N/A
### Original Help Text
```text
usage: TETyper.py [-h] --outprefix OUTPREFIX --ref REF [--refdb REFDB]
                  [--fq1 FQ1] [--fq2 FQ2] [--fq12 FQ12] [--bam BAM]
                  [--assembly ASSEMBLY] [--spades_params SPADES_PARAMS]
                  [--struct_profiles STRUCT_PROFILES]
                  [--snp_profiles SNP_PROFILES] --flank_len FLANK_LEN
                  [--min_reads MIN_READS] [--min_each_strand MIN_EACH_STRAND]
                  [--min_mapped_len MIN_MAPPED_LEN] [--min_qual MIN_QUAL]
                  [--show_region SHOW_REGION] [--threads THREADS]
                  [-v {1,2,3,4}] [--no_overwrite]

TETyper version 1.1. Given a set of input reads and a reference, TETyper
performs typing to identify: 1. deletions and SNP variation relative to the
reference, and 2. the immediate (up to ~20bp) sequence(s) flanking the
reference.

optional arguments:
  -h, --help            show this help message and exit
  --outprefix OUTPREFIX
                        Prefix to use for output files. Required.
  --ref REF             Reference sequence in fasta format. If not already
                        indexed with bwa, this will be created automatically.
                        A blast database is also required, again this will be
                        created automatically if it does not already exist.
                        Required.
  --refdb REFDB         Blast database corresponding to reference file (this
                        argument is only needed if the blast database was
                        created with a different name).
  --fq1 FQ1             Forward reads. Can be gzipped.
  --fq2 FQ2             Reverse reads. Can be gzipped.
  --fq12 FQ12           Interleaved forward and reverse reads.
  --bam BAM             Bam file containing reads mapped to the given
                        reference. If the reads have already been mapped, this
                        option saves time compared to specifying the reads in
                        fastq format. If this option is specified then --fq*
                        are ignored.
  --assembly ASSEMBLY   Use this assembly (fasta format) for detecting
                        structural variants instead of generating a new one.
                        This option saves time if an assembly is already
                        available.
  --spades_params SPADES_PARAMS
                        Additional parameters for running spades assembly.
                        Enclose in quotes and precede with a space. Default: "
                        --cov-cutoff auto --disable-rr". Ignored if --assembly
                        is specified.
  --struct_profiles STRUCT_PROFILES
                        File containing known structural variants. Tab
                        separated format with two columns. First column is
                        variant name. Second column contains a list of
                        sequence ranges representing deletions relative to the
                        reference, or "none" for no deletions. Each range
                        should be written as "startpos-endpos", with multiple
                        ranges ordered by start position and separated by a
                        "|" with no extra whitespace.
  --snp_profiles SNP_PROFILES
                        File containing known SNP profiles. Tab separated
                        format with three columns. First column: variant name,
                        second column: homozygous SNPs, third column:
                        heterozygous SNPs. SNPs should be written as
                        "refPOSalt", where "POS" is the position of that SNP
                        within the reference, "ref" is the reference base at
                        that position (A, C, G or T), and "alt" is the variant
                        base at that position (A, C, G or T for a homozygous
                        SNP; M, R, W, S, Y or K for a heterozygous SNP).
                        Multiple SNPs of the same type (homozygous or
                        heterozygous) should be ordered by position and
                        separated by a "|". "none" indicates no SNPs of the
                        given type.
  --flank_len FLANK_LEN
                        Length of flanking region to extract. Required.
  --min_reads MIN_READS
                        Minimum read number for including a specific flanking
                        sequence. Default 10.
  --min_each_strand MIN_EACH_STRAND
                        Minimum read number for each strand for including a
                        specific flanking sequence. Default 1.
  --min_mapped_len MIN_MAPPED_LEN
                        Minimum length of mapping for a read to be used in
                        determining flanking sequences. Higher values are more
                        robust to spurious mapping. Lower values will recover
                        more reads. Default 30.
  --min_qual MIN_QUAL   Minimum quality value across extracted flanking
                        sequence. Default 10.
  --show_region SHOW_REGION
                        Display presence/absence for a specific region of
                        interest within the reference (e.g. to display blaKPC
                        presence/absence with the Tn4401b-1 reference, use
                        "7202-8083")
  --threads THREADS     Number of threads to use for mapping and assembly
                        steps. Default: 1
  -v {1,2,3,4}, --verbosity {1,2,3,4}
                        Verbosity level for logging to stderr. 1 = ERROR, 2 =
                        WARNING, 3 = INFO, 4 = DUBUG. Default: 3.
  --no_overwrite        Flag to prevent accidental overwriting of previous
                        output files. In this mode, the pipeline checks for a
                        log file named according to the given output prefix.
                        If it exists then the pipeline exits without modifying
                        any files.
```

