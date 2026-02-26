# iva CWL Generation Report

## iva

### Tool Description
IVA is a de novo assembler for the de novo assembly of genomes from short reads.

### Metadata
- **Docker Image**: quay.io/biocontainers/iva:1.0.11--py_0
- **Homepage**: https://github.com/sanger-pathogens/iva
- **Package**: https://anaconda.org/channels/bioconda/packages/iva/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/iva/overview
- **Total Downloads**: 24.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/sanger-pathogens/iva
- **Stars**: N/A
### Original Help Text
```text
usage: iva [options] {-f reads_fwd -r reads_rev | --fr reads} <output directory>

positional arguments:
  Output directory      Name of output directory (must not already exist)

optional arguments:
  -h, --help            show this help message and exit

Input and output:
  -f filename[.gz], --reads_fwd filename[.gz]
                        Name of forward reads fasta/q file. Must be used in
                        conjunction with --reads_rev
  -r filename[.gz], --reads_rev filename[.gz]
                        Name of reverse reads fasta/q file. Must be used in
                        conjunction with --reads_fwd
  --fr filename[.gz]    Name of interleaved fasta/q file
  --keep_files          Keep intermediate files (could be many!). Default is
                        to delete all unnecessary files
  --contigs filename[.gz]
                        Fasta file of contigs to be extended. Incompatible
                        with --reference
  --reference filename[.gz]
                        EXPERIMENTAL! This option is EXPERIMENTAL, not
                        recommended, and has not been tested! Fasta file of
                        reference genome, or parts thereof. IVA will try to
                        assemble one contig per sequence in this file.
                        Incompatible with --contigs
  -v, --verbose         Be verbose by printing messages to stdout. Use up to
                        three times for increasing verbosity.

SMALT mapping options:
  -k INT, --smalt_k INT
                        kmer hash length in SMALT (the -k option in smalt
                        index) [19]
  -s INT, --smalt_s INT
                        kmer hash step size in SMALT (the -s option in smalt
                        index) [11]
  -y FLOAT, --smalt_id FLOAT
                        Minimum identity threshold for mapping to be reported
                        (the -y option in smalt map) [0.5]

Contig options:
  --ctg_first_trim INT  Number of bases to trim off the end of every contig
                        before extending for the first time [25]
  --ctg_iter_trim INT   During iterative extension, number of bases to trim
                        off the end of a contig when extension fails (then try
                        extending again) [10]
  --ext_min_cov INT     Minimum kmer depth needed to use that kmer to extend a
                        contig [10]
  --ext_min_ratio FLOAT
                        Sets N, where kmer for extension must be at least N
                        times more abundant than next most common kmer [4]
  --ext_max_bases INT   Maximum number of bases to try to extend on each
                        iteration [100]
  --ext_min_clip INT    Set minimum number of bases soft clipped off a read
                        for those bases to be used for extension [3]
  --max_contigs INT     Maximum number of contigs allowed in the assembly. No
                        more seeds generated if the cutoff is reached [50]

Seed generation options:
  --make_new_seeds      When no more contigs can be extended, generate a new
                        seed. This is forced to be true when --contigs is not
                        used
  --seed_start_length INT
                        When making a seed sequence, use the most common kmer
                        of this length. Default is to use the minimum of
                        (median read length, 95). Warning: it is not
                        recommended to set this higher than 95
  --seed_stop_length INT
                        Stop extending seed using perfect matches from reads
                        when this length is reached. Future extensions are
                        then made by treating the seed as a contig
                        [0.9*max_insert]
  --seed_min_kmer_cov INT
                        Minimum kmer coverage of initial seed [25]
  --seed_max_kmer_cov INT
                        Maximum kmer coverage of initial seed [1000000]
  --seed_ext_max_bases INT
                        Maximum number of bases to try to extend on each
                        iteration [50]
  --seed_overlap_length INT
                        Number of overlapping bases needed between read and
                        seed to use that read to extend [seed_start_length]
  --seed_ext_min_cov INT
                        Minimum kmer depth needed to use that kmer to extend a
                        contig [10]
  --seed_ext_min_ratio FLOAT
                        Sets N, where kmer for extension must be at least N
                        times more abundant than next most common kmer [4]

Read trimming options:
  --trimmomatic FILENAME
                        Provide location of trimmomatic.jar file to enable
                        read trimming. Required if --adapters used
  --trimmo_qual STRING  Trimmomatic options used to quality trim reads
                        [LEADING:10 TRAILING:10 SLIDINGWINDOW:4:20]
  --adapters FILENAME   Fasta file of adapter sequences to be trimmed off
                        reads. If used, must also use --trimmomatic. Default
                        is file of adapters supplied with IVA
  --min_trimmed_length INT
                        Minimum length of read after trimming [50]
  --pcr_primers FILENAME
                        FASTA file of primers. The first perfect match found
                        to a sequence in the primers file will be trimmed off
                        the start of each read. This is run after trimmomatic
                        (if --trimmomatic used)

Other options:
  -i INT, --max_insert INT
                        Maximum insert size (includes read length). Reads with
                        inferred insert size more than the maximum will not be
                        used to extend contigs [800]
  -t INT, --threads INT
                        Number of threads to use [1]
  --kmc_onethread       Force kmc to use one thread. By default the value of
                        -t/--threads is used when running kmc
  --strand_bias FLOAT in [0,0.5]
                        Set strand bias cutoff of mapped reads when trimming
                        contig ends, in the interval [0,0.5]. A value of x
                        means that a base needs min(fwd_depth, rev_depth) /
                        total_depth <= x. The only time this should be used is
                        with libraries with overlapping reads (ie fragment
                        length < 2*read length), and even then, it can make
                        results worse. If used, try a low value like 0.1 first
                        [0]
  --test                Run using built in test data. All other options will
                        be ignored, except the mandatory output directory, and
                        --trimmomatic and --threads can be also be used
  --version             show program's version number and exit
```

