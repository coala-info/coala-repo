# locityper CWL Generation Report

## locityper_target

### Tool Description
Adds target locus/loci to the database.

### Metadata
- **Docker Image**: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
- **Homepage**: https://github.com/tprodanov/locityper
- **Package**: https://anaconda.org/channels/bioconda/packages/locityper/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/locityper/overview
- **Total Downloads**: 19.6K
- **Last updated**: 2026-01-31
- **GitHub**: https://github.com/tprodanov/locityper
- **Stars**: N/A
### Original Help Text
```text
Adds target locus/loci to the database.

Usage: locityper target -d db -r ref.fa -j counts.jf [-v vars.vcf.gz] -l/-L loci [args]

Input/output arguments:
    -d, --database     DIR    Output database directory.
    -r, --reference    FILE   Reference FASTA file.
    -j, --jf-counts    FILE   Jellyfish k-mer counts (see documentation).
    -v, --variants     FILE   Input VCF file, encoding variation across pangenome samples.

Target loci: (may be repeated multiple times)
    -l, --locus        NAME REGION [FILE]
                              Locus name and coordinates. If VCF (-v) was not provided,
                              FASTA with locus alleles is required as a third argument.
    -L, --loci         FILE   BED file with loci coordinates. Fourth column: locus name.
                              If VCF (-v) was not provided, fifth column is required
                              with the path to locus alleles.

Allele extraction parameters:
    -g, --genome       STR    Name of the reference haplotype [default: tries to guess].
    -e, --expand       INT+   If needed, expand locus coordinates by <= INT bp [20k 50k 200k].
                              Boundaries are checked one by one until the locus
                              does not overlap any long pangenomic bubbles.
    -w, --window       INT    Select best locus boundary based on k-mer frequencies in
                              moving windows of size INT bp [500].
    -u, --unknown      NUM    Allow this fraction of unknown nucleotides per allele [0.0001]
                              (relative to the allele length). Variants that have no known
                              variation in the input VCF pangenome are ignored.
        --leave-out    STR+   Leave out sequences with specified names.
    -m, --minimizer   INT INT (k,w)-minimizers for sequence divergence calculation [15 15].
        --ignore-overl ░░░    Ignore overlapping variants. Default: fail with error.
                              Of several overlapping variants only the first one is used.

Execution arguments:
    -@, --threads      INT    Number of threads [8].
    -F, --force        ░░░    Force rewrite output directory.
        --jellyfish    EXE    Jellyfish executable [jellyfish].

Other arguments:
    -h, --help                Show this help message.
    -V, --version             Show version.
```


## locityper_prune

### Tool Description
Remove similar target haplotypes.

### Metadata
- **Docker Image**: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
- **Homepage**: https://github.com/tprodanov/locityper
- **Package**: https://anaconda.org/channels/bioconda/packages/locityper/overview
- **Validation**: PASS

### Original Help Text
```text
Remove similar target haplotypes.

Usage: locityper -i db -o pruned_db [args]

Input/output arguments:
    -i, --input       DIR   Input database directory.
    -o, --output      DIR   Output pruned database directory.
    -a, --alignments  PATH  Path to alignment .paf[.gz] files [haplotypes.paf.gz].
                            Should either contain {}, which are then replaced with locus names,
                            or direct to files located in INPUT/loci/<locus>/PATH.
                            Alignments can be constructed using locityper align.

Optional arguments:
        --field       STR   PAF field with divergence values [dv].
        --threshold   NUM   Divergence threshold for pruning [0.0002].
        --n-clusters  INT   Use dynamic threshold to get approximately INT clusters.
        --power       NUM   Select cluster representative with the smallest
                            generalized mean of this power [2].
        --subset-loci STR+  Limit the pruning to loci from this list.
        --skip-tree   ░░░   Do not write trees in the output directory.
    -F, --force       ░░░   Force rewrite output directory.

Other arguments:
    -h, --help              Show this help message.
    -V, --version           Show version.
```


## locityper_preproc

### Tool Description
Preprocess WGS dataset.

### Metadata
- **Docker Image**: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
- **Homepage**: https://github.com/tprodanov/locityper
- **Package**: https://anaconda.org/channels/bioconda/packages/locityper/overview
- **Validation**: PASS

### Original Help Text
```text
Preprocess WGS dataset.

Usage:
    locityper preproc (-i reads1.fq [reads2.fq] | -a reads.bam [--no-index] | -I in-list) \
        -r reference.fa -j counts.jf -o out [args]
    locityper preproc -i/-a/-I <input> -~ similar -r reference.fa -j counts.jf -o out [args]
    locityper preproc --describe -o out

This is a short help message. Please use -H/--full-help to see the full help.

Input/output arguments:  (please see documentation for more information on -i/-a/-I arguments)
    -i, --input        FILE+  Reads 1 and 2 in FASTA or FASTQ format, optionally gzip compressed.
                              Reads 1 are required, reads 2 are optional.
    -a, --alignment FILE [FILE]  Reads in BAM/CRAM format, mutually exclusive with -i/--input.
                              Unless --no-index, mapped, sorted & indexed BAM/CRAM file is expected.
                              If provided, second file should contain path to the alignment index.
    -I, --in-list      FILE   File with input filenames (see documentation).
    -r, --reference    FILE   Reference FASTA file. Must be indexed with FAIDX.
    -j, --jf-counts    FILE   Jellyfish k-mer counts (see documentation).
    -o, --output       DIR    Output directory.
    -~, --like         DIR    This dataset is similar to already preprocessed dataset.
                              Use with care. Only utilizes difference in the number of reads.

Optional arguments:
    -^, --interleaved  ░░░    Interleaved paired-end reads in single input file.
        --no-index     ░░░    Use input full BAM/CRAM file (-a) without index.
                              Single-end and paired-end interleaved (-^) data is allowed.
    -t, --tech         STR    Sequencing technology [illumina]:
                              sr  | illumina : short-read sequencing,
                                hifi         : PacBio HiFi,
                              pb  | pacbio   : PacBio CLR,
                              ont | nanopore : Oxford Nanopore.

Execution arguments:
    -@, --threads      INT    Number of threads [8].
        --rerun        STR    Rerun mode [none]. Rerun everything (all); do not rerun
                              read mapping (part); do not rerun (none).
        --describe     ░░░    Simply describe already preprocessed data.
        --debug        ░░░    Save debug CSV files.

Other arguments:
    -h, --help                Show short help message.
    -H, --full-help           Show extended help message.
    -V, --version             Show version.
```


## locityper_genotype

### Tool Description
Genotype complex loci.

### Metadata
- **Docker Image**: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
- **Homepage**: https://github.com/tprodanov/locityper
- **Package**: https://anaconda.org/channels/bioconda/packages/locityper/overview
- **Validation**: PASS

### Original Help Text
```text
Genotype complex loci.

Usage:
    locityper genotype (-i reads1.fq [reads2.fq] | -a reads.bam [--no-index] | -I in-list) \
        -p preproc -d db -o out [args]

This is a short help message. Please use -H/--full-help to see the full help.

Input/output arguments:  (please see documentation for more information on -i/-a/-I arguments)
    -i, --input        FILE+  Reads 1 and 2 in FASTA or FASTQ format, optionally gzip compressed.
                              Reads 1 are required, reads 2 are optional.
    -a, --alignment FILE [FILE]  Reads in BAM/CRAM format, mutually exclusive with -i/--input.
                              Unless --no-index, mapped, sorted & indexed BAM/CRAM file is expected.
                              If provided, second file should contain path to the alignment index.
    -I, --in-list      FILE   File with input filenames (see documentation).
    -r, --reference    FILE   Reference FASTA file. Required with input CRAM file (-a alns.cram).
    -p, --preproc      DIR    Preprocessed dataset directory or `.gz` file (see locityper preproc).
    -d, --database[s]  DIR+   Database directory (see locityper target).
                              Multiple databases allowed, but must contain unique loci names.
    -o, --output       DIR    Output directory.
    -O, --out-bams     INT    Output BAM files for INT best genotypes [0].

Optional arguments:
    -^, --interleaved  ░░░    Interleaved paired-end reads in single input file.
        --no-index     ░░░    Use input BAM/CRAM file (-a) without index: goes over all reads.
                              Single-end and paired-end interleaved (-^) data is allowed.

Execution arguments:
    -@, --threads      INT    Number of threads [8].
        --rerun        STR    Rerun mode [none]. Rerun all loci (all); do not rerun
                              read recruitment (part); do not rerun completed loci (none).
        --stop-after   STR    Stop after one of the steps: recruit, map or all (default).
    -s, --seed         INT    Random seed. Ensures reproducibility for the same
                              input and program version.
        --debug        INT    Save debug CSV files: 0 = none, 1 = some, 2 = all.

Other arguments:
    -h, --help                Show this help message.
    -H, --full-help           Show extended help message.
    -V, --version             Show version.
```


## locityper_align

### Tool Description
Align medium-size sequence to each other.

### Metadata
- **Docker Image**: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
- **Homepage**: https://github.com/tprodanov/locityper
- **Package**: https://anaconda.org/channels/bioconda/packages/locityper/overview
- **Validation**: PASS

### Original Help Text
```text
Align medium-size sequence to each other.

Usage: locityper -i input.fa -o out.paf (-p name,name | -P pairs.txt | -A) [args]

Input/output arguments:
    -i, --input      FILE   Input FASTA file.
    -o, --output     FILE   Output PAF[.gz] file.
        --prefix     PATH   Prefix for temporary files (for multiple threads).

Alignment pairs (mutually exclusive):
    -p, --pairs      STR+   Find alignments for these pairs (two names separated by comma),
                            many pairs allowed.
    -P, --pairs-file FILE   Find alignments for these pairs (two column file).
    -A, --all        ░░░    Find alignments for all pairs.

Alignment arguments:
    -m, --minimizer INT INT (k,w)-minimizers for sequence divergence calculation [15 15].
    -s, --skip-div   ░░░    Skip divergence calculation.
    -D, --thresh-div NUM    Do not align sequences with minimizer divergence >= NUM [0.5].
                            Use -D 1 to align everything.
    -k, --backbone   INT    One or more k-mer sizes (5 <= k <= 127) for backbone alignment,
                            separated by comma [25,51,101].
    -g, --max-gap    INT    Do not complete gaps over this size [500].
    -a, --accuracy   INT    Alignment accuracy level (1-9) [9].
    -M, --mismatch   INT    Penalty for mismatch [4].
    -O, --gap-open   INT    Gap open penalty [6].
    -E, --gap-extend INT    Gap extend penalty [1].

Execution arguments:
    -@, --threads    INT    Number of threads [8].

Other arguments:
    -h, --help              Show this help message.
    -V, --version           Show version.
```


## locityper_recruit

### Tool Description
Recruit reads to one/multiple loci.

### Metadata
- **Docker Image**: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
- **Homepage**: https://github.com/tprodanov/locityper
- **Package**: https://anaconda.org/channels/bioconda/packages/locityper/overview
- **Validation**: PASS

### Original Help Text
```text
Recruit reads to one/multiple loci.

Usage:
    locityper recruit \
        (-i reads1.fq [reads2.fq] | -a reads.bam [--no-index] | -I in-list) \
        (-s seqs.fa | -S all_seqs.fa) -o out.fastq [args]

Input/output arguments:  (please see documentation for more information on -i/-a/-I arguments)
    -i, --input        FILE+  Reads 1 and 2 in FASTA or FASTQ format, optionally gzip compressed.
                              Reads 1 are required, reads 2 are optional.
    -a, --alignment FILE [FILE]  Reads in BAM/CRAM format, mutually exclusive with -i/--input.
                              Unless --no-index, mapped, sorted & indexed BAM/CRAM file is expected.
                              If provided, second file should contain path to the alignment index.
    -I, --in-list      FILE   File with input filenames (see documentation).
    -r, --reference    FILE   Reference FASTA file. Required with input CRAM file (-a alns.cram).
    -j, --jf-counts    FILE   Canonical k-mer counts across the reference genome, calculated
                              using Jellyfish. Not required, but highly recommended. k does not
                              have to match minimizer size. See docs for recommended options.

Optional arguments:
    -^, --interleaved  ░░░    Interleaved paired-end reads in single input file.
        --no-index     ░░░    Use input BAM/CRAM file (-a) without index: goes over all reads.
                              Single-end and paired-end interleaved (-^) data is allowed.

Target sequences and output arguments:
    -s, --seqs         FILE   FASTA file with target sequences for one locus.
                              To recruit reads to multiple loci, replace locus name with `{}`.
                              Then, all matching files will be selected.
                              Multiple entries allowed, but locus names must not repeat.
    -S, --seqs-all     FILE   Single FASTA file with target sequences for all loci.
                              Unless --distinct, record names should have format `LOCUS*SEQ_NAME`.
                              Mutually exclusive with -s.
        --distinct     ░░░    Every sequence represents a distinct target (only with -S).
    -o, --output       FILE   Path to the (interleaved) output FASTQ files.
                              If the path contains `{}`, it will replaced by the locus name.
                              Note: Will create parent directories, if needed.
                              Note: For performance reasons, only single output can be gzipped.
    -l, --seqs-list    FILE   Two column file with input FASTA and output FASTQ filenames.
                              Mutually exclusive with -s, -S and -o.
    -R, --regions      FILE   Recruit unmapped reads and reads with primary alignments to these
                              regions (BED). Only relevant for mapped and indexed BAM/CRAM files.
        --alt-contig   INT    Recruit reads mapped to contigs shorter than this [10M].
                              Only used together with -R for mapped and indexed BAM/CRAM files.

Read recruitment:
    -m, --minimizer  INT INT  Use k-mers of size INT_1 (<= 31) with smallest hash
                              across INT_2 consecutive k-mers [15 10].
    -M, --match-frac   NUM    Minimal fraction of minimizers that need to match reference [0.5].
    -L, --match-len    INT    Recruit long reads with a matching subregion of this length [2000].
    -t, --kmer-thresh  INT    Only use k-mers that appear less than INT times in the
                              reference genome [10]. Requires -j argument.
    -c, --chunk-size   INT    Recruit reads in chunks of this size [10k].
                              Impacts runtime in multi-threaded read recruitment.
    -x, --preset       STR    Parameter preset (illumina|illumina-SE|hifi|pacbio|ont).
                              Modifies -m, -M, see locityper genotype for default values.
                              Additionally, changes -c to 300 for long reads.

Subsampling:
        --subsample    NUM    Before recruitment, subsample reads at this rate [1].
        --seed         INT    Subsampling seed (optional). Ensures reproducibility
                              for the same input and program version.

Execution arguments:
    -@, --threads      INT    Number of threads [8].
        --jellyfish    EXE    Jellyfish executable [jellyfish].

Other arguments:
    -h, --help                Show this help message.
    -V, --version             Show version.
```


## locityper_cite

### Tool Description
No inputs — do not generate CWL.

### Metadata
- **Docker Image**: quay.io/biocontainers/locityper:1.3.4--ha6fb395_0
- **Homepage**: https://github.com/tprodanov/locityper
- **Package**: https://anaconda.org/channels/bioconda/packages/locityper/overview
- **Validation**: FAIL (generation failed)

### Generation Failed

No inputs — do not generate CWL.


### Validation Errors

- No inputs — do not generate CWL.



### Original Help Text
```text
Thank you for using our tool!

Please cite our paper:
    T.Prodanov, E.G.Plender, G.Seebohm, S.G.Meuth, E.E.Eichler, T.Marschall.
    Locityper enables targeted genotyping of complex polymorphic genes.
    Nature Genetics 57, 2901-2908 (2025). https://doi.org/10.1038/s41588-025-02362-4
```

