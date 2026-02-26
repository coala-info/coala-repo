# mason CWL Generation Report

## mason_mason_variator

### Tool Description
Either simulate variation and write out the result to VCF and optionally FASTA files.

### Metadata
- **Docker Image**: quay.io/biocontainers/mason:2.0.13--h7f3286b_0
- **Homepage**: https://www.seqan.de/apps/mason.html
- **Package**: https://anaconda.org/channels/bioconda/packages/mason/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/mason/overview
- **Total Downloads**: 28.2K
- **Last updated**: 2026-02-11
- **GitHub**: https://github.com/seqan/seqan
- **Stars**: N/A
### Original Help Text
```text
mason_variator - Variation Simulation
=====================================

SYNOPSIS
    mason_variator [OPTIONS] -ir IN.fa -ov OUT.vcf [-of OUT.fa]

DESCRIPTION
    Either simulate variation and write out the result to VCF and optionally
    FASTA files.

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    --version
          Display version information.

  General Options:
    -q, --quiet
          Set verbosity to a minimum.
    -v, --verbose
          Enable verbose output.
    -vv, --very-verbose
          Enable very verbose output.
    -s, --seed UINT64
          The seed to use for the random number generator. Default: 0.

  Input / Output:
    -ir, --in-reference INPUT_FILE
          FASTA file with reference. Valid filetypes are: .fasta and .fa.
    -it, --in-variant-tsv INPUT_FILE
          TSV file with variants to simulate. See Section on the Variant TSV
          File below. Valid filetypes are: .txt and .tsv.
    -ov, --out-vcf INPUT_FILE
          VCF file to write simulated variations to. Valid filetype is: .vcf.
    -of, --out-fasta INPUT_FILE
          FASTA file to write simulated haplotypes to. Valid filetypes are:
          .fasta and .fa.
    --out-breakpoints OUTPUT_FILE
          TSV file to write breakpoints in variants to. Valid filetypes are:
          .txt and .tsv.
    --haplotype-name-sep STRING
          Haplotype name separator in output FASTA. Default: /.
    --no-gen-var-ids
          Do not generate variant ids.

  Haplotype / Allele Configuration:
    -n, --num-haplotypes INTEGER
          The number of haplotypes to simulate. In range [1..inf]. Default: 1.
    --haplotype-sep STRING
          The separator between the chromosome and the haplotype name in the
          output FASTA file. Default: /.

  Variation Simulation:
    --snp-rate DOUBLE
          Per-base SNP rate. In range [0.0..1.0]. Default: 0.0001.
    --small-indel-rate DOUBLE
          Small indel rate. In range [0.0..1.0]. Default: 0.000001.
    --min-small-indel-size INTEGER
          Minimal small indel size to simulate. In range [0..inf]. Default: 1.
    --max-small-indel-size INTEGER
          Maximal small indel size to simulate. In range [0..inf]. Default: 6.
    --sv-indel-rate DOUBLE
          Per-base SNP rate. In range [0.0..1.0]. Default: 0.0000001.
    --sv-inversion-rate DOUBLE
          Per-base SNP rate. In range [0.0..1.0]. Default: 0.0000001.
    --sv-translocation-rate DOUBLE
          Per-base SNP rate. In range [0.0..1.0]. Default: 0.0000001.
    --sv-duplication-rate DOUBLE
          Per-base SNP rate. In range [0.0..1.0]. Default: 0.0000001.
    --min-sv-size INTEGER
          Minimal SV size to simulate. In range [0..inf]. Default: 50.
    --max-sv-size INTEGER
          Maximal SV size to simulate. In range [0..inf]. Default: 1000.

  Methylation Level Simulation:
    --methylation-levels
          Enable methylation level simulation.
    --meth-cg-mu DOUBLE
          Median of beta distribution for methylation level of CpG loci. In
          range [0..1]. Default: 0.6.
    --meth-cg-sigma DOUBLE
          Standard deviation of beta distribution for methylation level of CpG
          loci. In range [0..1]. Default: 0.03.
    --meth-chg-mu DOUBLE
          Median of beta distribution for methylation level of CHG loci. In
          range [0..1]. Default: 0.08.
    --meth-chg-sigma DOUBLE
          Standard deviation of beta distribution for methylation level of CHG
          loci. In range [0..1]. Default: 0.008.
    --meth-chh-mu DOUBLE
          Median of beta distribution for methylation level of CHH loci. In
          range [0..1]. Default: 0.05.
    --meth-chh-sigma DOUBLE
          Standard deviation of beta distribution for methylation level of CHH
          loci. In range [0..1]. Default: 0.005.
    --meth-fasta-in INPUT_FILE
          Path to load original methylation levels from. Methylation levels
          are simulated if omitted. Valid filetypes are: .sam[.*], .raw[.*],
          .gbk[.*], .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*],
          .fasta[.*], .fas[.*], .faa[.*], .fa[.*], .embl[.*], and .bam, where
          * is any of the following extensions: gz, bz2, and bgzf for
          transparent (de)compression.
    --meth-fasta-out OUTPUT_FILE
          Path to write methylation levels to as FASTA. Only written if
          -of/--out-fasta is given. Valid filetypes are: .sam[.*], .raw[.*],
          .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*], .fasta[.*],
          .fas[.*], .faa[.*], .fa[.*], and .bam, where * is any of the
          following extensions: gz, bz2, and bgzf for transparent
          (de)compression.

SIMULATION DETAILS
    SNPs and small indels are simulated such that at each position, a random
    experiment is performed whether to simulate either variation. In case both
    variations are to be simulated, the experiment is repeated.

    The indel and SV sizes are picked uniformly at random from the argument
    size intervals.

    The simulation of haplotypes works as follows. For small indels, the indel
    is placed into one of the haplotypes that are to be simulated. The exact
    haplotype is picked uniformly at random. For SNPs, we simulate a random
    base for each haplotype. For at least one haplotype, the base has to be
    different from the reference or the experiment is repeated.

VARIATION TSV FILE
    Instead of simulating the SVs from per-base rates, the user can specify a
    TSV (tab separated values) file to load the variations from with
    --in-variant-tsv/-it. The first two columns of this TSV file are
    interpreted as the type of the variation and the size. For insertions, you
    can give the sequence that is to be inserted. The length of the given
    sequence overrides the length given in the second column.

    Indels smaller than 50 bp are considered small indels whereas larger
    indels are considered structural variants in the VCF file.

    INS   An insertion.
    DEL   A deletion.
    INV   An inversion.
    CTR   An intra-chromosomal translocation.
    DUP   A duplication

METHYLATION LEVEL SIMULATION
    Simulation of cytosine methylation levels is done using a beta
    distribution. There is one distribution each for cytosines in the context
    CpG, CHG, and CHH and one distribution for all other cytonsines. You can
    give the parameters mu and sigma of the beta distributions. The
    methylation level is determined once for each base of the reference (0 for
    all non-cytosines) and stored in a string of levels. This string is then
    modified as small and structural variations are simualted.

    The simulated methylation levels can then be written out to a FASTA file.
    This file will contain two entries for the original and each haplotype;
    the levels for the forward and the reverse strand. The sequence will be
    ASCII characters 0, starting at '!' encoding the level in 1.25% steps. The
    character '>' is ignored and encodes no level.

    Methylation level simulation increases the memory usage of the program by
    one byte for each character in the largest contig.

VERSION
    Last update: 
    mason_variator version: 2.0.13 [tarball]
    SeqAn version: 2.5.2
```


## mason_mason_simulator

### Tool Description
Simulate NUM reads/pairs from the reference sequence IN.fa, potentially with variants from IN.vcf.

### Metadata
- **Docker Image**: quay.io/biocontainers/mason:2.0.13--h7f3286b_0
- **Homepage**: https://www.seqan.de/apps/mason.html
- **Package**: https://anaconda.org/channels/bioconda/packages/mason/overview
- **Validation**: PASS

### Original Help Text
```text
mason_simulator - Read Simulation
=================================

SYNOPSIS
    mason_simulator [OPTIONS] -ir IN.fa -n NUM [-iv IN.vcf] -o LEFT.fq [-or
    RIGHT.fq]

DESCRIPTION
    Simulate NUM reads/pairs from the reference sequence IN.fa, potentially
    with variants from IN.vcf. In case that both -o and -or are given, write
    out paired-end data, if only -io is given, only single-end reads are
    simulated.

OPTIONS
    -h, --help
          Display the help message.
    --version-check BOOL
          Turn this option off to disable version update notifications of the
          application. One of 1, ON, TRUE, T, YES, 0, OFF, FALSE, F, and NO.
          Default: 1.
    --version
          Display version information.
    -q, --quiet
          Low verbosity.
    -v, --verbose
          Higher verbosity.
    -vv, --very-verbose
          Highest verbosity.
    --seed UINT64
          Seed to use for random number generator. Default: 0.
    --meth-seed UINT64
          Seed to use for methylation level random number generator. Default:
          0.
    --seed-spacing UINT64
          Offset for seeds to use when multi-threading. Default: 2048.
    --num-threads INTEGER
          Number of threads to use.See note about Parallelism at the end of
          the help page. In range [1..inf]. Default: 1.
    --force-single-end
          Force single-end simulation although --out-right file is given.
    --chunk-size INTEGER
          Number of fragments to simulate in one batch. See note about
          Parallelism at the end of the help page. In range [1..inf]. Default:
          900.
    -n, --num-fragments INTEGER
          Number of reads/pairs to simulate. In range [1..inf].
    --meth-fasta-in INPUT_FILE
          FASTA file with methylation levels of the input file. Valid
          filetypes are: .sam[.*], .raw[.*], .gbk[.*], .frn[.*], .fq[.*],
          .fna[.*], .ffn[.*], .fastq[.*], .fasta[.*], .fas[.*], .faa[.*],
          .fa[.*], .embl[.*], and .bam, where * is any of the following
          extensions: gz, bz2, and bgzf for transparent (de)compression.
    -o, --out OUTPUT_FILE
          Output of single-end/left end reads. Valid filetypes are: .sam[.*],
          .raw[.*], .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*],
          .fasta[.*], .fas[.*], .faa[.*], .fa[.*], and .bam, where * is any of
          the following extensions: gz, bz2, and bgzf for transparent
          (de)compression.
    -or, --out-right OUTPUT_FILE
          Output of right reads. Giving this options enables paired-end
          simulation. Valid filetypes are: .sam[.*], .raw[.*], .frn[.*],
          .fq[.*], .fna[.*], .ffn[.*], .fastq[.*], .fasta[.*], .fas[.*],
          .faa[.*], .fa[.*], and .bam, where * is any of the following
          extensions: gz, bz2, and bgzf for transparent (de)compression.
    -oa, --out-alignment OUTPUT_FILE
          SAM/BAM file with alignments. Valid filetypes are: .sam[.*] and
          .bam, where * is any of the following extensions: gz, bz2, and bgzf
          for transparent (de)compression.

  Apply VCF Variants to Reference:
    -ir, --input-reference INPUT_FILE
          Path to FASTA file to read the reference from. Many contigs in a
          reference might be a problem due to many file handles that need to
          be opened. Check the hard limit of file handles with 'ulimit -Hn'
          and increase the soft limit to the hard limit with 'ulimit -Sn
          <number>' if necessary. Valid filetypes are: .sam[.*], .raw[.*],
          .gbk[.*], .frn[.*], .fq[.*], .fna[.*], .ffn[.*], .fastq[.*],
          .fasta[.*], .fas[.*], .faa[.*], .fa[.*], .embl[.*], and .bam, where
          * is any of the following extensions: gz, bz2, and bgzf for
          transparent (de)compression.
    -iv, --input-vcf INPUT_FILE
          Path to the VCF file with variants to apply. Valid filetype is:
          .vcf[.*], where * is any of the following extensions: gz, bz2, and
          bgzf for transparent (de)compression.

  Methylation Level Simulation:
    --methylation-levels
          Enable methylation level simulation.
    --meth-cg-mu DOUBLE
          Median of beta distribution for methylation level of CpG loci. In
          range [0..1]. Default: 0.6.
    --meth-cg-sigma DOUBLE
          Standard deviation of beta distribution for methylation level of CpG
          loci. In range [0..1]. Default: 0.03.
    --meth-chg-mu DOUBLE
          Median of beta distribution for methylation level of CHG loci. In
          range [0..1]. Default: 0.08.
    --meth-chg-sigma DOUBLE
          Standard deviation of beta distribution for methylation level of CHG
          loci. In range [0..1]. Default: 0.008.
    --meth-chh-mu DOUBLE
          Median of beta distribution for methylation level of CHH loci. In
          range [0..1]. Default: 0.05.
    --meth-chh-sigma DOUBLE
          Standard deviation of beta distribution for methylation level of CHH
          loci. In range [0..1]. Default: 0.005.

  Fragment Size (Insert Size) Options:
    --fragment-size-model STRING
          The model to use for the fragment size simulation. One of normal and
          uniform. Default: normal.
    --fragment-min-size INTEGER
          Smallest fragment size to use when using uniform fragment size
          simulation. In range [1..inf]. Default: 100.
    --fragment-max-size INTEGER
          Largest fragment size to use when using uniform fragment size
          simulation. In range [1..inf]. Default: 400.
    --fragment-mean-size INTEGER
          Mean fragment size for normally distributed fragment size
          simulation. In range [1..inf]. Default: 300.
    --fragment-size-std-dev INTEGER
          Fragment size standard deviation when using normally distributed
          fragment size simulation. In range [1..inf]. Default: 30.

  Global Read Simulation Options:
    --seq-technology STRING
          Set sequencing technology to simulate. One of illumina, 454, and
          sanger. Default: illumina.
    --seq-mate-orientation STRING
          Orientation for paired reads. See section Read Orientation below.
          One of FR, RF, FF, and FF2. Default: FR.
    --seq-strands STRING
          Strands to simulate from, only applicable to paired sequencing
          simulation. One of forward, reverse, and both. Default: both.
    --embed-read-info
          Whether or not to embed read information.
    --read-name-prefix STRING
          Read names will have this prefix. Default: simulated..

  BS-Seq Options:
    --enable-bs-seq
          Enable BS-seq simulation.
    --bs-seq-protocol STRING
          Protocol to use for BS-Seq simulation. One of directional and
          undirectional. Default: directional.
    --bs-seq-conversion-rate DOUBLE
          Conversion rate for unmethylated Cs to become Ts. In range [0..1].
          Default: 0.99.

  Illumina Options:
    --illumina-read-length INTEGER
          Read length for Illumina simulation. In range [1..inf]. Default:
          100.
    --illumina-error-profile-file INPUT_FILE
          Path to file with Illumina error profile. The file must be a text
          file with floating point numbers separated by space, each giving a
          positional error rate. Valid filetype is: .txt.
    --illumina-prob-insert DOUBLE
          Insert per-base probability for insertion in Illumina sequencing. In
          range [0..1]. Default: 0.00005.
    --illumina-prob-deletion DOUBLE
          Insert per-base probability for deletion in Illumina sequencing. In
          range [0..1]. Default: 0.00005.
    --illumina-prob-mismatch-scale DOUBLE
          Scaling factor for Illumina mismatch probability. In range [0..inf].
          Default: 1.0.
    --illumina-prob-mismatch DOUBLE
          Average per-base mismatch probability in Illumina sequencing. In
          range [0.0..1.0]. Default: 0.004.
    --illumina-prob-mismatch-begin DOUBLE
          Per-base mismatch probability of first base in Illumina sequencing.
          In range [0.0..1.0]. Default: 0.002.
    --illumina-prob-mismatch-end DOUBLE
          Per-base mismatch probability of last base in Illumina sequencing.
          In range [0.0..1.0]. Default: 0.012.
    --illumina-position-raise DOUBLE
          Point where the error curve raises in relation to read length. In
          range [0.0..1.0]. Default: 0.66.
    --illumina-quality-mean-begin DOUBLE
          Mean PHRED quality for non-mismatch bases of first base in Illumina
          sequencing. Default: 40.0.
    --illumina-quality-mean-end DOUBLE
          Mean PHRED quality for non-mismatch bases of last base in Illumina
          sequencing. Default: 39.5.
    --illumina-quality-stddev-begin DOUBLE
          Standard deviation of PHRED quality for non-mismatch bases of first
          base in Illumina sequencing. Default: 0.05.
    --illumina-quality-stddev-end DOUBLE
          Standard deviation of PHRED quality for non-mismatch bases of last
          base in Illumina sequencing. Default: 10.0.
    --illumina-mismatch-quality-mean-begin DOUBLE
          Mean PHRED quality for mismatch bases of first base in Illumina
          sequencing. Default: 40.0.
    --illumina-mismatch-quality-mean-end DOUBLE
          Mean PHRED quality for mismatch bases of last base in Illumina
          sequencing. Default: 30.0.
    --illumina-mismatch-quality-stddev-begin DOUBLE
          Standard deviation of PHRED quality for mismatch bases of first base
          in Illumina sequencing. Default: 3.0.
    --illumina-mismatch-quality-stddev-end DOUBLE
          Standard deviation of PHRED quality for mismatch bases of last base
          in Illumina sequencing. Default: 15.0.
    --illumina-left-template-fastq INPUT_FILE
          FASTQ file to use for a template for left-end reads. Valid filetypes
          are: .sam[.*], .raw[.*], .gbk[.*], .frn[.*], .fq[.*], .fna[.*],
          .ffn[.*], .fastq[.*], .fasta[.*], .fas[.*], .faa[.*], .fa[.*],
          .embl[.*], and .bam, where * is any of the following extensions: gz,
          bz2, and bgzf for transparent (de)compression.
    --illumina-right-template-fastq INPUT_FILE
          FASTQ file to use for a template for right-end reads. Valid
          filetypes are: .sam[.*], .raw[.*], .gbk[.*], .frn[.*], .fq[.*],
          .fna[.*], .ffn[.*], .fastq[.*], .fasta[.*], .fas[.*], .faa[.*],
          .fa[.*], .embl[.*], and .bam, where * is any of the following
          extensions: gz, bz2, and bgzf for transparent (de)compression.

  Sanger Sequencing Options:
    --sanger-read-length-model STRING
          The model to use for sampling the Sanger read length. One of normal
          and uniform. Default: normal.
    --sanger-read-length-min INTEGER
          The minimal read length when the read length is sampled uniformly.
          In range [0..inf]. Default: 400.
    --sanger-read-length-max INTEGER
          The maximal read length when the read length is sampled uniformly.
          In range [0..inf]. Default: 600.
    --sanger-read-length-mean DOUBLE
          The mean read length when the read length is sampled with normal
          distribution. In range [0..inf]. Default: 400.
    --sanger-read-length-error DOUBLE
          The read length standard deviation when the read length is sampled
          uniformly. In range [0..inf]. Default: 40.
    --sanger-prob-mismatch-scale DOUBLE
          Scaling factor for Sanger mismatch probability. In range [0..inf].
          Default: 1.0.
    --sanger-prob-mismatch-begin DOUBLE
          Per-base mismatch probability of first base in Sanger sequencing. In
          range [0.0..1.0]. Default: 0.005.
    --sanger-prob-mismatch-end DOUBLE
          Per-base mismatch probability of last base in Sanger sequencing. In
          range [0.0..1.0]. Default: 0.001.
    --sanger-prob-insertion-begin DOUBLE
          Per-base insertion probability of first base in Sanger sequencing.
          In range [0.0..1.0]. Default: 0.0025.
    --sanger-prob-insertion-end DOUBLE
          Per-base insertion probability of last base in Sanger sequencing. In
          range [0.0..1.0]. Default: 0.005.
    --sanger-prob-deletion-begin DOUBLE
          Per-base deletion probability of first base in Sanger sequencing. In
          range [0.0..1.0]. Default: 0.0025.
    --sanger-prob-deletion-end DOUBLE
          Per-base deletion probability of last base in Sanger sequencing. In
          range [0.0..1.0]. Default: 0.005.
    --sanger-quality-match-start-mean DOUBLE
          Mean PHRED quality for non-mismatch bases of first base in Sanger
          sequencing. Default: 40.0.
    --sanger-quality-match-end-mean DOUBLE
          Mean PHRED quality for non-mismatch bases of last base in Sanger
          sequencing. Default: 39.5.
    --sanger-quality-match-start-stddev DOUBLE
          Mean PHRED quality for non-mismatch bases of first base in Sanger
          sequencing. Default: 0.1.
    --sanger-quality-match-end-stddev DOUBLE
          Mean PHRED quality for non-mismatch bases of last base in Sanger
          sequencing. Default: 2.
    --sanger-quality-error-start-mean DOUBLE
          Mean PHRED quality for erroneous bases of first base in Sanger
          sequencing. Default: 30.
    --sanger-quality-error-end-mean DOUBLE
          Mean PHRED quality for erroneous bases of last base in Sanger
          sequencing. Default: 20.
    --sanger-quality-error-start-stddev DOUBLE
          Mean PHRED quality for erroneous bases of first base in Sanger
          sequencing. Default: 2.
    --sanger-quality-error-end-stddev DOUBLE
          Mean PHRED quality for erroneous bases of last base in Sanger
          sequencing. Default: 5.

  454 Sequencing Options:
    --454-read-length-model STRING
          The model to use for sampling the 454 read length. One of normal and
          uniform. Default: normal.
    --454-read-length-min INTEGER
          The minimal read length when the read length is sampled uniformly.
          In range [0..inf]. Default: 10.
    --454-read-length-max INTEGER
          The maximal read length when the read length is sampled uniformly.
          In range [0..inf]. Default: 600.
    --454-read-length-mean DOUBLE
          The mean read length when the read length is sampled with normal
          distribution. In range [0..inf]. Default: 400.
    --454-read-length-stddev DOUBLE
          The read length standard deviation when the read length is sampled
          with normal distribution. In range [0..inf]. Default: 40.
    --454-no-sqrt-in-std-dev
          For error model, if set then (sigma = k * r)) is used, otherwise
          (sigma = k * sqrt(r)).
    --454-proportionality-factor DOUBLE
          Proportionality factor for calculating the standard deviation
          proportional to the read length. In range [0..inf]. Default: 0.15.
    --454-background-noise-mean DOUBLE
          Mean of lognormal distribution to use for the noise. In range
          [0..inf]. Default: 0.23.
    --454-background-noise-stddev DOUBLE
          Standard deviation of lognormal distribution to use for the noise.
          In range [0..inf]. Default: 0.15.

SIMULATION OVERVIEW
    The first step is the application of VCF variants to the input reference
    file.

    After the generation of the haplotypes, fragments are sampled from the
    sequence. These fragments correspond to the fragments in the real
    preparation step for the sequencing. They are later sequenced from one or
    both sides depending on whether a single-end or a paired protocol is used.

IMPORTANT PARAMETERS
    For most users, the following options are most important.

    Paired-End Simulation
          Use --fragment-length-model to switch between normally and uniformly
          distributed insert sizes. Use the --fragment-* options for
          configuring the insert size simulation.

MULTI-THREADING
    When using multi-threading, each thread gets its own random number
    generator (RNG). The RNG of thread i is initialized with the value of
    --seed plus i.

BAM/SAM TAGS
    Mason can write out a BAM or SAM file with alignments of the reads against
    the reference. The records have tags that give information about the
    simulated reads. Below is a list of the tags and their meaning.

    NM    Edit distance when aligned to the reference (i).
    MD    String for mismatching positions (Z).
    oR    Name of original reference, (Z).
    oH    Number of the original hhaplotype (1-based), (i).
    oP    original position on the original reference (i).
    oS    original strand, F/R for forward and reverse strand (A).
    uR    Reason for being unaligned, I/B for being in insertion or spanning
          over breakpoint.
    XE    Number of sequencing errors in the read (i).
    XS    Number of SNPs in the read alignment (i).
    XI    Number of small indels in the read alignment (i).

VCF VARIANT NOTES
    If the option --input-vcf/-iv is given then the given VCF file is read and
    the variants are applied to the input reference file. If it is not given
    then the input reference file is taken verbatimly for simulating reads.

    There are some restrictions on the VCF file and the application of the
    variants to the reference will fail if the VCF file is non-conforming. VCF
    files from the mason_variator program are guaranteed to be read.

    Only the haplotypes of the first individual will be generated.

FRAGMENT SIZE (INSERT SIZE) SIMULATION
    You can choose between a normal and a uniform distribution of fragment
    lengths. When sequencing these fragments from both sides in a paired
    protocol, the fragment size will become the insert size.

SEQUENCING SIMULATION
    Simulation of base qualities is disabled when writing out FASTA files.
    Simulation of paired-end sequencing is enabled when specifying two output
    files.

READ ORIENTATION
    You can use the --mate-orientation to set the relative orientation when
    doing paired-end sequencing. The valid values are given in the following.

    FR    Reads are inward-facing, the same as Illumina paired-end reads: R1
          --> <-- R2.
    RF    Reads are outward-facing, the same as Illumina mate-pair reads: R1
          <-- --> R2.
    FF    Reads are on the same strand: R1 --> --> R2.
    FF2   Reads are on the same strand but the "right" reads are sequenced to
          the left of the "left" reads, same as 454 paired: R2 --> --> R1.

PARALLELISM
    General
          The contigs are processed sequentially. For each contig, the
          fragments/reads are simulated in parallel by `--num-threads` many
          threads. The threads simulate batches of `chunks-size` many
          fragments each. This is done until no more fragments are left to be
          simulated.
    CPU-Utilization
          When the number of fragments to simulate per contig is low, it may
          happen that not all threads are utilized. For example, when there
          are 20,000 fragments to simulate for a contig, 32 threads are
          available, and each thread simulates batches of 1000
          (`--chunk-size`) fragments, only 20 threads are utilized. Hence,
          `--chunk-size` affects CPU-utilization. However, very low
          chunk-sizes also lead to a large overhead, especially when using
          only one thread. While we set a sensible default, perfomance gains
          may be achieved by trying different chunk-sizes.
    Randomization
          Both `--chunk-size` and `--num-threads` affect randomization.
          Different values for these parameters yield different results.

VERSION
    Last update: 
    mason_simulator version: 2.0.13 [tarball]
    SeqAn version: 2.5.2
```

