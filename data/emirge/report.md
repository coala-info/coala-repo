# emirge CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| emirge_emirge.py | Failed | image problem: the image has no usearch program, which emirge.py needs at start |
| emirge_emirge_amplicon.py | Failed | image problem: the image has no usearch program, which emirge_amplicon.py needs at start |
| emirge_emirge_makedb.py | PASS | downloaded real SILVA 128 LSU data, clustered sequences of 3150-3300 bp at 97 percent and built a bowtie index; the default SSU database is much larger and was not run |
| emirge_emirge_rename_fasta.py | PASS | synthetic data: a small iter.01 folder built from three real NCBI 16S sequences; sorting by prior, record prefix, prob_min filter and N trimming were correct |

## emirge_emirge_makedb.py

### Tool Description
emirge_makedb.py creates a reference database and the necessay indices for use by EMIRGE from an rRNA reference database. Without extra parameters, emirge_makedb.py will 1) download the most recent SILVA SSU database, 2) filter it by sequence length, 3) cluster at 97% sequence identity, 4) replace ambiguous bases with random characters and 5) create a bowtie index.

### Metadata
- **Docker Image**: quay.io/biocontainers/emirge:0.61.1--py27_1
- **Homepage**: https://github.com/csmiller/EMIRGE
- **Package**: Not found
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/emirge/overview
- **Total Downloads**: 11.1K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/csmiller/EMIRGE
- **Stars**: N/A
### Original Help Text
```text
Usage: emirge_makedb.py [OPTIONS]

emirge_makedb.py creates a reference database and the necessay indices for use by
EMIRGE from an rRNA reference database. Without extra parameters, emirge_makedb.py
will 1) download the most recent SILVA SSU database, 2) filter it by sequence
length, 3) cluster at 97% sequence identity, 4) replace ambiguous bases
with random characters and 5) create a bowtie index.

Requires vsearch executable can be found in path for clustering.
https://github.com/torognes/vsearch

Requires bowtie-build (from bowtie version 1) can be found in path
    


Options:
  -h, --help            show this help message and exit
  -g [SSU|LSU], --gene=[SSU|LSU]
                        build database from this gene (SSU=Small Subunit rRNA;
                        LSU=Large Subunit rRNA) default = SSU
  -p THREADS, --threads=THREADS
                        number of threads to use for vsearch clustering of
                        database (default = use all available)
  -t DIR, --tmpdir=DIR  working directory for temporary files (default = /tmp)
  -r N, --release=N     SILVA release number (default: current SILVA release)
  -m LEN, --min-len=LEN
                        minimum reference sequence length (default = 1200)
  -M LEN, --max-len=LEN
                        maximum reference sequence length (default = 2000)
  -i FLOAT, --id=FLOAT  Cluster at this fractional identity level (default =
                        0.97)
  -k, --keep            keep intermediary files (default: do not keep)
  -V FILE, --vsearch=FILE
                        path to vsearch binary (default: look in $PATH)
  -B FILE, --bowtie-build=FILE
                        path to bowtie-build binary (default: look in $PATH)
  --silva-license-accepted
                        I have read and accepted the SILVA license.
```


## emirge_emirge_rename_fasta.py

### Tool Description
Rewrites an emirge fasta file to include proper sequence names and prior probabilities (abundance estimates) in the record headers, and sorts the sequences from most to least abundant

### Metadata
- **Docker Image**: quay.io/biocontainers/emirge:0.61.1--py27_1
- **Homepage**: https://github.com/csmiller/EMIRGE
- **Package**: Not found
- **Validation**: PASS

### Original Help Text
```text
Usage: emirge_rename_fasta.py [options] <iter.DIR> > renamed.fasta

emirge_rename_fasta.py rewrites an emirge fasta file to include proper
sequence names and prior probabilities (abundance estimates) in the
record headers, and sorts the sequences from most to least abundant

iter.DIR is one of the iteration directories created by emirge (for
example: emirge_working_dir/iter.40).  If no iter.DIR is given,
emirge_rename_fasta.py assumes that iter.DIR is the current working
directory.

Note that, with default options, bases with no read support are
labeled 'N', and terminal N's are trimmed

Options:
  -h, --help            show this help message and exit
  -p PROB_MIN, --prob_min=PROB_MIN
                        Only include sequences in output with prior
                        probability above PROB_MIN (Default: include all
                        sequences)
  -r RECORD_PREFIX, --record_prefix=RECORD_PREFIX
                        Add the specified prefix to each fasta record title
  -n, --no_N            Don't change bases with no read support to N.
                        Caution: these bases are not supported by reads in the
                        input data, but will usually be from a closely related
                        sequence.
  -t, --no_trim_N       Don't trim off N bases with no read support from ends
                        of sequences.  Ignored if --no_N is also passed
```


## emirge_emirge.py

### Tool Description
EMIRGE attempts to reconstruct rRNA SSU genes from Illumina metagenomic data

### Metadata
- **Docker Image**: quay.io/biocontainers/emirge:0.61.1--py27_1
- **Homepage**: https://github.com/csmiller/EMIRGE
- **Package**: https://anaconda.org/channels/bioconda/packages/emirge/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: emirge.py DIR <required_parameters> [options]

This version of EMIRGE (emirge.py) attempts to reconstruct rRNA SSU genes from
Illumina metagenomic data.
DIR is the working directory to process data in.
Use --help to see a list of required and optional arguments

Additional information:
https://groups.google.com/group/emirge-users
https://github.com/csmiller/EMIRGE/wiki

If you use EMIRGE in your work, please cite these manuscripts, as appropriate.

Miller CS, Baker BJ, Thomas BC, Singer SW, Banfield JF (2011)
EMIRGE: reconstruction of full-length ribosomal genes from microbial community short read sequencing data.
Genome biology 12: R44. doi:10.1186/gb-2011-12-5-r44.

Miller CS, Handley KM, Wrighton KC, Frischkorn KR, Thomas BC, Banfield JF (2013)
Short-Read Assembly of Full-Length 16S Amplicons Reveals Bacterial Diversity in Subsurface Sediments.
PloS one 8: e56018. doi:10.1371/journal.pone.0056018.


Options:
  -h, --help            show this help message and exit

  Required flags:
    These flags are all required to run EMIRGE, and may be supplied in any
    order.

    -1 reads_1.fastq[.gz]
                        path to fastq file with \1 (forward) reads from
                        paired-end sequencing run, or all reads from single-
                        end sequencing run.  File may optionally be gzipped.
                        EMIRGE expects ASCII-offset of 64 for quality scores.
                        (Note that running EMIRGE with single-end reads is
                        largely untested.  Please let me know how it works for
                        you.)
    -f FASTA_DB, --fasta_db=FASTA_DB
                        path to fasta file of candidate SSU sequences
    -b BOWTIE_DB, --bowtie_db=BOWTIE_DB
                        precomputed bowtie index of candidate SSU sequences
                        (path to appropriate prefix; see --fasta_db)
    -l MAX_READ_LENGTH, --max_read_length=MAX_READ_LENGTH
                        length of longest read in input data.

  Required flags for paired-end reads:
    These flags are required to run EMIRGE when you have paired-end reads
    (the standard way of running EMIRGE), and may be supplied in any
    order.

    -2 reads_2.fastq    path to fastq file with \2 (reverse) reads from
                        paired-end run.  File must be unzipped for mapper.
                        EMIRGE expects ASCII-offset of 64 for quality scores.
    -i INSERT_MEAN, --insert_mean=INSERT_MEAN
                        insert size distribution mean.
    -s INSERT_STDDEV, --insert_stddev=INSERT_STDDEV
                        insert size distribution standard deviation.

  Optional parameters:
    Defaults should normally be fine for these options in order to run
    EMIRGE

    -n ITERATIONS, --iterations=ITERATIONS
                        Number of iterations to perform.  It may be necessary
                        to use more iterations for more complex samples
                        (default=40)
    -a PROCESSORS, --processors=PROCESSORS
                        Number of processors to use in the mapping steps.  You
                        probably want to raise this if you have the
                        processors. (default: 1)
    -m MAPPING, --mapping=MAPPING
                        path to precomputed initial mapping (bam file).  If
                        not provided, and initial mapping will be run for you.
    -p SNP_FRACTION_THRESH, --snp_fraction_thresh=SNP_FRACTION_THRESH
                        If fraction of variants in a candidate sequence
                        exceeds this threhold, then split the candidate into
                        two sequences for next iteration.  See also
                        --variant_fraction_thresh. (default: 0.04)
    -v VARIANT_FRACTION_THRESH, --variant_fraction_thresh=VARIANT_FRACTION_THRESH
                        minimum probability of second most probable base at a
                        site required in order to call site a variant.  See
                        also --snp_fraction_thresh.  (default: 0.1)
    -j JOIN_THRESHOLD, --join_threshold=JOIN_THRESHOLD
                        If two candidate sequences share >= this fractional
                        identity over their bases with mapped reads, then
                        merge the two sequences into one for the next
                        iteration.  (default: 0.97; valid range: [0.95, 1.0] )
    -c MIN_DEPTH, --min_depth=MIN_DEPTH
                        minimum average read depth below which a candidate
                        sequence is discarded for next iteration(default: 3)
    --nice_mapping=NICE_MAPPING
                        If set, during mapping phase, the mapper will be
                        "niced" by the Linux kernel with this value (default:
                        no nice)
    --phred33           Illumina quality values in fastq files are the (fastq
                        standard) ascii offset of Phred+33.  This is the new
                        default for Illumina pipeline >= 1.8. DEFAULT is still
                        to assume that quality scores are Phred+64
    -e SAVE_EVERY, --save_every=SAVE_EVERY
                        every SAVE_EVERY iterations, save some information
                        about the program's state.  This is solely for
                        debugging information, and is NOT required to resume a
                        run (see --resume_from below).  (default=none)

  Resuming iterations:
    These options allow you to resume iterations from a previously
    completed EMIRGE iteration.  This requires that directories for the
    iteration to resume from and the previous iteration both be present.
    It is STRONGLY recommended that other options set on the command line
    be identical to the original run.  Note that EMIRGE does not check
    this for you!

    -r RESUME_FROM, --resume_from=RESUME_FROM
                        Resume iterations from COMPLETED iteration specified.
                        Requires that the iteration and previous iteration
                        fully completed, i.e. a priors file, bam file, and
                        fasta file are all present in the iteration directory.
```

## emirge_emirge_amplicon.py

### Tool Description
EMIRGE amplicon reconstructs full-length rRNA SSU genes from Illumina 16S amplicon data

### Metadata
- **Docker Image**: quay.io/biocontainers/emirge:0.61.1--py27_1
- **Homepage**: https://github.com/csmiller/EMIRGE
- **Package**: https://anaconda.org/channels/bioconda/packages/emirge/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: emirge_amplicon.py DIR <required_parameters> [options]

This version of EMIRGE (emirge_amplicon.py) attempts to reconstruct rRNA SSU genes
from Illumina amplicon data.  It can handle up to a few million rRNA
reads at a time.
DIR is the working directory to process data in.
Use --help to see a list of required and optional arguments

Additional information:
https://groups.google.com/group/emirge-users
https://github.com/csmiller/EMIRGE/wiki

If you use EMIRGE in your work, please cite these manuscripts, as appropriate.

Miller CS, Baker BJ, Thomas BC, Singer SW, Banfield JF (2011)
EMIRGE: reconstruction of full-length ribosomal genes from microbial community short read sequencing data.
Genome biology 12: R44. doi:10.1186/gb-2011-12-5-r44.

Miller CS, Handley KM, Wrighton KC, Frischkorn KR, Thomas BC, Banfield JF (2013)
Short-Read Assembly of Full-Length 16S Amplicons Reveals Bacterial Diversity in Subsurface Sediments.
PloS one 8: e56018. doi:10.1371/journal.pone.0056018.


Options:
  -h, --help            show this help message and exit

  Required flags:
    These flags are all required to run EMIRGE, and may be supplied in any
    order.

    -1 reads_1.fastq[.gz]
                        path to fastq file with \1 (forward) reads from
                        paired-end sequencing run, or all reads from single-
                        end sequencing run.  File may optionally be gzipped.
                        EMIRGE expects ASCII-offset of 64 for quality scores
                        (but see --phred33).  (Note that running EMIRGE with
                        single-end reads is largely untested.  Please let me
                        know how it works for you.)
    -f FASTA_DB, --fasta_db=FASTA_DB
                        path to fasta file of candidate SSU sequences
    -b BOWTIE_DB, --bowtie_db=BOWTIE_DB
                        precomputed bowtie index of candidate SSU sequences
                        (path to appropriate prefix; see --fasta_db)
    -l MAX_READ_LENGTH, --max_read_length=MAX_READ_LENGTH
                        length of longest read in input data.

  Required flags for paired-end reads:
    These flags are required to run EMIRGE when you have paired-end reads
    (the standard way of running EMIRGE), and may be supplied in any
    order.

    -2 reads_2.fastq    path to fastq file with \2 (reverse) reads from
                        paired-end run.  File must be unzipped for mapper.
                        EMIRGE expects ASCII-offset of 64 for quality scores
                        (but see --phred33).
    -i INSERT_MEAN, --insert_mean=INSERT_MEAN
                        insert size distribution mean.
    -s INSERT_STDDEV, --insert_stddev=INSERT_STDDEV
                        insert size distribution standard deviation.

  Optional parameters:
    Defaults should normally be fine for these options in order to run
    EMIRGE

    -n ITERATIONS, --iterations=ITERATIONS
                        Number of iterations to perform.  It may be necessary
                        to use more iterations for more complex samples
                        (default=40)
    -a PROCESSORS, --processors=PROCESSORS
                        Number of processors to use in the mapping steps.  You
                        probably want to raise this if you have the
                        processors. (default: 1)
    -m MAPPING, --mapping=MAPPING
                        path to precomputed initial mapping (bam file).  If
                        not provided, an initial mapping will be run for you.
    -p SNP_FRACTION_THRESH, --snp_fraction_thresh=SNP_FRACTION_THRESH
                        If fraction of variants in a candidate sequence
                        exceeds this threhold, then split the candidate into
                        two sequences for next iteration.  See also
                        --variant_fraction_thresh. (default: 0.04)
    -v VARIANT_FRACTION_THRESH, --variant_fraction_thresh=VARIANT_FRACTION_THRESH
                        minimum probability of second most probable base at a
                        site required in order to call site a variant.  See
                        also --snp_fraction_thresh.  (default: 0.1)
    -j JOIN_THRESHOLD, --join_threshold=JOIN_THRESHOLD
                        If two candidate sequences share >= this fractional
                        identity over their bases with mapped reads, then
                        merge the two sequences into one for the next
                        iteration.  (default: 0.97; valid range: [0.95, 1.0] )
    -c MIN_LENGTH_COVERAGE, --min_length_coverage=MIN_LENGTH_COVERAGE
                        minimum fraction of the length of a candidate
                        reference sequence that must be covered by mapped
                        reads.  If not met, a candidate sequence is discarded
                        for the next iteration.  (default: 0.3; valid range:
                        (0.0, 1.0])
    --nice_mapping=NICE_MAPPING
                        If set, during mapping phase, the mapper will be
                        "niced" by the Linux kernel with this value (default:
                        no nice)
    --phred33           Illumina quality values in fastq files are the (fastq
                        standard) ascii offset of Phred+33.  This is the new
                        default for Illumina pipeline >= 1.8. DEFAULT is still
                        to assume that quality scores are Phred+64
```

## Metadata
- **Skill**: generated
