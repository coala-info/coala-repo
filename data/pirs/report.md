# pirs CWL Generation Report

## pirs_diploid

### Tool Description
Simulate a diploid genome by creating a copy of a haploid genome with heterozygosity introduced. REFERENCE specifies a FASTA file containing the reference genome. It may be compressed (gzip). It may contain multiple sequences (scaffolds or chromosomes), each marked with a separate FASTA tag line. The introduced heterozygosity takes the form of SNPs, indels, and large-scale structural variation (insertions, deletions and inversions). If REFERENCE is '-', the reference sequence is read from stdin, but it must be uncompressed.

### Metadata
- **Docker Image**: quay.io/biocontainers/pirs:2.0.2--pl5.22.0_1
- **Homepage**: https://github.com/galaxy001/pirs
- **Package**: https://anaconda.org/channels/bioconda/packages/pirs/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/pirs/overview
- **Total Downloads**: 6.9K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/galaxy001/pirs
- **Stars**: N/A
### Original Help Text
```text
Usage: pirs diploid [OPTIONS...] REFERENCE

Simulate a diploid genome by creating a copy of a haploid genome with
heterozygosity introduced.  REFERENCE specifies a FASTA file containing
the reference genome.  It may be compressed (gzip).  It may contain multiple
sequences (scaffolds or chromosomes), each marked with a separate FASTA tag
line.  The introduced heterozygosity takes the form of SNPs, indels, and
large-scale structural variation (insertions, deletions and inversions).
If REFERENCE is '-', the reference sequence is read from stdin, but it must be
uncompressed.

The probabilities of SNPs, indels, and large-scale structural variation can be
specified with the '-s', '-d', and '-v' options, respectively.  You can also
set the ratio of transitions to transversions (for SNPs) with the '-R' option.

Indels are split evenly between insertions and deletions. The length
distribution of the indels is as follows and is derived from panda
re-sequencing data:
	1bp	64.82%
	2bp	17.17%
	3bp	7.20%
	4bp	7.29%
	5bp	2.18%
	6bp	1.34%

Large-scale structural variation is split evenly among large-scale insertions,
deletions, and inversions.  By default, the length distribution of these
large-scale features is as follows:
	100bp	70%
	200bp	20%
	500bp	7%
	1000bp	2%
	2000bp	1%

`pirs diploid' does not use multiple threads, even if pIRS was configured with
--enable-multiple threads.

OPTIONS:
  -s, --snp-rate=RATE    A floating-point number in the interval [0, 1] that
                           specifies the heterozygous SNP rate.  Default: 0.001

  -d, --indel-rate=RATE  A floating-point number in the interval [0, 1] that
                           specifies the heterozygous indel rate.
                           Default: 0.0001

  -v, --sv-rate=RATE     A floating-point number in the interval [0, 1] that
                         specifies the large-scale structural variation
                         (insertion, deletion, inversion) rate in the diploid
                           genome. Default: 0.000001

  -R, --transition-to-transversion-ratio=RATIO
                         In a SNP, a transition is when a purine or pyrimidine
                           is changed to one of the same (A <=> G, C <=> T)
                           while a transversion is when a purine is changed
                           into a pyrimidine or vice-versa.  This option
                           specifies a floating-point number RATIO that gives
                           the ratio of the transition probability to the
                           transversion probability for simulated SNPs.
                           Default: 2.0

  -o, --output-prefix=PREFIX
                         Use PREFIX as the prefix of the output file and logs.
                           Default: "pirs_diploid"

  -O, --output-file=FILE
                        Use FILE as the name of the output file. Use '-'
                           for standard output; this also moves the
                           informational messages from stdout to stderr.

  -c, --output-file-type=TYPE
                         The string "text" or "gzip" to specify the type of
                           the output FASTA file containing the diploid copy
                           of the genome, as well as the log files.
                           Default: "text"

  -n, --no-logs          Do not write the log files.

  -S, --random-seed=SEED Use SEED as the random seed. Default:
                           time(NULL) * getpid()

  -q, --quiet            Do not print informational messages.

  -h, --help             Show this help and exit.

  -V, --version          Show version information and exit.

EXAMPLE:
  ./pirs diploid ref_sequence.fa -s 0.001 -d 0.0001 -v 0.000001\
                 -o ref_sequence >pirs.out 2>pirs.err
```


## pirs_simulate

### Tool Description
pIRS is a program for simulating paired-end reads from a genome. It is optimized for simulating reads from the Illumina platform. The input to pIRS is any number of reference sequences. Typically you would just provide one FASTA file containing your reference sequence, but you may provide two if you have generated a diploid sequence with `pirs diploid', or if you have chromosomes split up into multiple FASTA files. The output of pIRS is two FASTQ files containing the simulated paired-end reads, as well as several log files.

### Metadata
- **Docker Image**: quay.io/biocontainers/pirs:2.0.2--pl5.22.0_1
- **Homepage**: https://github.com/galaxy001/pirs
- **Package**: https://anaconda.org/channels/bioconda/packages/pirs/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: ./pirs simulate [OPTION]... REFERENCE.FASTA...

pIRS is a program for simulating paired-end reads from a genome.  It is
optimized for simulating reads from the Illumina platform.  The input to
pIRS is any number of reference sequences. Typically you would just provide
one FASTA file containing your reference sequence, but you may provide two
if you have generated a diploid sequence with `pirs diploid', or if you have
chromosomes split up into multiple FASTA files.  The output of pIRS is two
FASTQ files containing the simulated paired-end reads, as well as several log
files.

Input sequences are assumed to be haploid.  If you instead want to simulate
reads from a diploid genome, you must give the --diploid option so that
the diploidy is taken into account when computing coverage.  If you do
not do this, you will get twice as many reads as you wanted.

pIRS simulates a normally-distributed insert (fragment) length using the
Box-muller method.  Usually you want the insert length standard deviation to
be 1/20 or 1/10 of the insert length mean (see the -m and -v options).
This program also simulates Illumina sequencing error, quality score and
GC bias based on empirical distribution profiles. Users may use the default
profiles in this package, which are generated by large real sequencing data,
or they may generate their own profiles.

OPTIONS:
  -l LEN, --read-len=LEN
                Generate reads having a length of LEN.  Default: 100

  -x VAL, --coverage=VAL
                 Set the average sequencing coverage (sometimes called depth).
                 It may be either a floating-point number or an integer.

  -m LEN, --insert-len-mean=LEN
                 Generate inserts (fragments) having an average length of LEN.
                 Default: 180

  -v LEN, --insert-len-sd=LEN
                 Set the standard deviation of the insert (fragment) length.
                 Default: 10% of insert length mean.

  -j, --jumping, --cyclicize
                 Make the paired-end reads face away from either other, as
                 in a jumping library.  Default: the reads face towards each
                 other.

  -d, --diploid
                 This option asserts that reads are being simulated from a
                 diploid genome.  It causes the program to abort if there
                 are not exactly two reference sequences; in addition, the
                 coverage is divided in half, since the two reference
                 sequences are in reality the same genome.  This option
                 is not required to simulate diploid reads, but you must
                 set the coverage correctly otherwise (it will be half
                 as much as you think).

  -B FILE, --base-calling-profile=FILE, --subst-error-profile=FILE
                 Use FILE as the base-calling profile.  This profile will be
                 used to simulate substitution errors.  Default:
                 /usr/local/share/pirs/Base-Calling_Profiles/humNew.PE100.matrix.gz

  -I FILE, --indel-error-profile=FILE, --indel-profile=FILE
                 Use FILE as the indel-error profile.  This profile will be
                 used to simulate insertions and deletions in the reads that
                 are artifacts of the sequencing process.  Default:
                 /usr/local/share/pirs/InDel_Profiles/phixv2.InDel.matrix

  -G FILE, --gc-bias-profile=FILE, --gc-content-bias-profile=FILE
                 Use FILE as the GC content bias profile.  This profile will
                 adjust the read coverage based on the GC content of
                 fragments.  Defaults:
                 /usr/local/share/pirs/GC-depth_Profiles/humNew.gcdep_100.dat,
                 /usr/local/share/pirs/GC-depth_Profiles/humNew.gcdep_150.dat,
                 /usr/local/share/pirs/GC-depth_Profiles/humNew.gcdep_200.dat,
                 depending on the mean insert length.

  -e FILE, --error-rate=RATE, --subst-error-rate=RATE
                 Set the substitution error rate.  The base-calling profile
                 will still be used, but the average frequency of errors will
                 be changed to RATE.  Set to 0 to disable substitution errors
                 completely.  In that case, the base-calling profile will not
                 be used.  Default: default error rate of base-calling
                 profile.

                 Note: since pIRS parameterizes the error rate by
                 several parameters, it is very difficult to determine exactly
                 what needs to be done to make the error rate be a given
                 value.  We try to adjust the probabilities of getting each
                 quality score in order to accomodate the user-supplied error
                 rate.  However, depending on your input sequences, the actual
                 error rate simulated by pIRS could be off by 20% or more.
                 Please check the informational output to see the final error
                 rate that was actually simulated.

  -A ALGO, --substitution-error-algorithm=ALGO, --subst-error-algo=ALGO
                 Set the algorithm used for simulating substitition errors.
                 It may be set to the string "dist" or "qtrans".  The
                 default is "qtrans".

                 The "dist" algorithm looks up the substitution error rate
                 for each base pair based on the current cycle and the true
                 base.  This lookup produces a quality score and a called base
                 that may or may not be the same as the true base.  In the
                 base-calling profile, the matrix we use is marked as the
                 [DistMatrix].

                 The "qtrans" algorithm is a Markov-chain model based on the
                 previous quality score and current cycle.  The next quality
                 score is looked up with a certain probability based on these
                 parameters.  The matrix used for this is marked as
                 [QTransMatrix] in the base-calling profile. Then, the the
                 DistMatrix is used to find a called base for the quality score.
                 The DistMatrix is also used to call the base in the first
                 cycle.

  -M MODE, --mask=MODE, --eamss=MODE
                 Use the EAMSS algorithm for masking read quality.  MODE may be
                 the string "quality" or "lowercase".  The EAMSS algorithm
                 identifies low-quality, GC-rich regions near the ends of reads.
                 "quality" mode will change the quality scores on these
                 regions to (2 + quality_shift), while "lowercase" mode
                 will change the base pairs to lower case, but not change
                 the quality values.  Default: Do not use EAMSS.

  -Q VAL, --quality-shift=VAL, --phred-offset=VAL
                 Set the ASCII shift of the quality value (usually 64 or 33 for
                 Illumina data).  Default: 33

  --no-quality-values
  --fasta
                 Do not simulate quality values.  The simulated reads will be
                 written as a FASTA file rather than a FASTQ file.
                 Substitution errors may still be done; if you do not want
                 to simulate any substition errors, provide --error-rate=0 or
                 --no-substitution-errors.

  --no-subst-errors
  --no-substitution-errors
                 Do not simulate substitution errors.  Equivalent to
                 --error-rate=0.

  --no-indels
  --no-indel-errors
                 Do not simulate indels.  The indel error profile will not be
                 used.

  --no-gc-bias
  --no-gc-content-bias
                 Do not simulate GC bias.  The GC bias profile will not be
                 used.

  -o PREFIX, --output-prefix=PREFIX
                 Use PREFIX as the prefix of the output files.  Default:
                 "pirs_reads"

  -c TYPE, --output-file-type=TYPE
                 The string "text" or "gzip" to specify the type of
                 the output FASTQ files containing the simulated reads
                 of the genome, as well as the log files.  Default: "text"

  -z, --compress
                 Equivalent to -c gzip.

  -n, --no-logs, --no-log-files
                 Do not write the log files.

  -S SEED, --random-seed=SEED
                 Use SEED as the random seed. Default:
                 time(NULL) * getpid().  Note: If pIRS was not compiled with
                 --disable-threads, each thread actually uses its own random
                 number generator that is seeded by this base seed added to
                 the thread number; also, if you need pIRS's output to be
                 exactly reproducible, you must specify the random seed as well
                 as use only 1 simulator thread (--threads=1, or configure
                 with --disable-threads, or run on system with 4 or fewer
                 processors).

  -t, --threads=NUM_THREADS
                 Use NUM_THREADS threads to simulate reads.  This option is
                 not available if pIRS was compiled with the --disable-threads
                 option.  Default: number of processors minus 2 if writing
                 uncompressed output, or number of processors minus 3 if
                 writing compressed output, or 1 if there are not this many
                 processors.

  -q, --quiet    Do not print informational messages.

  -h, --help     Show this help and exit.

  -V, --version  Show version information and exit.
```


## Metadata
- **Skill**: generated
