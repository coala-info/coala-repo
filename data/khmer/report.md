# khmer CWL Generation Report

## Real Data Test

| Tool | Result | Reason |
|---|---|---|
| khmer_abundance-dist-single.py | PASS | histogram of sarscov2 test_1 k-mers (9146 distinct, bins 1-5) equals an independent count; countgraph saved |
| khmer_abundance-dist.py | PASS | histogram of test_1 k-mers from the countgraph of both read files; every bin equals an independent k-mer count |
| khmer_count-median.py | PASS | sarscov2 test_1 reads against the load-into-counting countgraph; median, average and length of the first read match an independent count |
| khmer_do-partition.py | PASS | khmer random-20-a.fa partitioned; the annotated .part file is identical to the Galaxy expected output |
| khmer_extract-long-sequences.py | PASS | sarscov2 test_1 reads of at least 140 bp: 77 kept, equal to an awk count |
| khmer_extract-paired-reads.py | PASS | khmer paired-mixed.fa split into 3 read pairs (.pe) and 5 orphans (.se), 11 reads in total |
| khmer_fastq-to-fasta.py | PASS | 100 reads from the khmer test data converted to FASTA |
| khmer_filter-abund-single.py | PASS | khmer test reads trimmed at cutoff 2; all 1001 trimmed reads equal an independent calculation |
| khmer_filter-abund.py | PASS | countgraph built with load-into-counting.py in the same image; the single-copy read was trimmed to the abundant k-mers |
| khmer_interleave-reads.py | PASS | khmer paired test reads interleaved |
| khmer_load-graph.py | PASS | 200 sarscov2 reads at k=20: nodegraph, tagset and info written; 12787 unique k-mers, equal to an independent count |
| khmer_load-into-counting.py | PASS | 100 paired sarscov2 Illumina reads (2 files) loaded at k=20; the countgraph info shows 12787 unique k-mers, equal to an independent count |
| khmer_normalize-by-median.py | PASS | khmer test reads at k=17: kept counts matched the Galaxy expected report (1001 reads, 1 or 2 kept by cutoff; 6 paired reads, 2 kept with paired mode) |
| khmer_partition-graph.py | PASS | nodegraph and tagset built with load-graph.py in the same image; subset pmap file written |
| khmer_readstats.py | PASS | sarscov2 test_1 and test_2: 100 reads each, 13897 and 13748 bp, equal to an independent count |
| khmer_sample-reads-randomly.py | PASS | 20 of 100 sarscov2 reads sampled (one and two samples), all taken from the input; note: with more than one input file the tool stops with an AssertionError (tool bug) |
| khmer_split-paired-reads.py | PASS | sarscov2 reads interleaved with khmer, then split again: 100 left and 100 right reads with the original names; orphan file empty |
| khmer_trim-low-abund.py | PASS | 100 sarscov2 reads at k=20: 40 reads kept, no kept k-mer below the cutoff; summary table and countgraph written |
| khmer_unique-kmers.py | PASS | sarscov2 reads at k=20: estimated 12821 unique k-mers, within 0.3% of the exact 12787; report file written |

## Metadata
- **Skill**: generated

## khmer_filter-abund.py

### Tool Description
Trim sequences at a minimum k-mer abundance.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter-abund.py [--version] [--info] [-h] [-T THREADS] [-C CUTOFF] [-V]
                       [-Z NORMALIZE_TO] [-o optional_output_filename] [-f]
                       [-q] [--gzip | --bzip]
                       input_count_graph_filename input_sequence_filename
                       [input_sequence_filename ...]

Trim sequences at a minimum k-mer abundance.

positional arguments:
  input_count_graph_filename
                        The input k-mer countgraph filename
  input_sequence_filename
                        Input FAST[AQ] sequence filename

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -T THREADS, --threads THREADS
                        Number of simultaneous threads to execute (default: 1)
  -C CUTOFF, --cutoff CUTOFF
                        Trim at k-mers below this abundance. (default: 2)
  -V, --variable-coverage
                        Only trim low-abundance k-mers from sequences that
                        have high coverage. (default: False)
  -Z NORMALIZE_TO, --normalize-to NORMALIZE_TO
                        Base the variable-coverage cutoff on this median k-mer
                        abundance. (default: 20)
  -o optional_output_filename, --output optional_output_filename
                        Output the trimmed sequences into a single file with
                        the given filename instead of creating a new file for
                        each input file. (default: None)
  -f, --force           Overwrite output file if it exists (default: False)
  -q, --quiet
  --gzip                Compress output using gzip (default: False)
  --bzip                Compress output using bzip2 (default: False)

Trimmed sequences will be placed in "${input_sequence_filename}.abundfilt" for
each input sequence file. If the input sequences are from RNAseq or metagenome
sequencing then `--variable-coverage` should be used.

Example:

    load-into-counting.py -k 20 -x 5e7 countgraph data/100k-filtered.fa
    filter-abund.py -C 2 countgraph data/100k-filtered.fa
WARNING: Skipping mount /etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

|| This is the script filter-abund.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||   * Q Zhang et al., http://dx.doi.org/10.1371/journal.pone.0101271
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_partition-graph.py

### Tool Description
Partition a sequence graph based upon waypoint connectivity

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: partition-graph.py [--version] [--info] [-h] [-S filename]
                          [-s SUBSET_SIZE] [--no-big-traverse] [-f]
                          [-T THREADS]
                          basename

Partition a sequence graph based upon waypoint connectivity

positional arguments:
  basename              basename of the input k-mer nodegraph + tagset files

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -S filename, --stoptags filename
                        Use stoptags in this file during partitioning
                        (default: )
  -s SUBSET_SIZE, --subset-size SUBSET_SIZE
                        Set subset size (usually 1e5-1e6 is good) (default:
                        100000)
  --no-big-traverse     Truncate graph joins at big traversals (default:
                        False)
  -f, --force           Overwrite output file if it exists (default: False)
  -T THREADS, --threads THREADS
                        Number of simultaneous threads to execute (default: 1)

The resulting partition maps are saved as "${basename}.subset.#.pmap" files.
WARNING: Skipping mount /etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

|| This is the script partition-graph.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||   * J Pell et al., http://dx.doi.org/10.1073/pnas.1121464109
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_interleave-reads.py

### Tool Description
Produce interleaved files from R1/R2 paired files

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: interleave-reads.py [--version] [--info] [-h] [-o filename]
                           [--no-reformat] [-f] [--gzip | --bzip]
                           left right

Produce interleaved files from R1/R2 paired files

positional arguments:
  left
  right

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -o filename, --output filename
  --no-reformat         Do not reformat read names or enforce consistency
                        (default: False)
  -f, --force           Overwrite output file if it exists (default: False)
  --gzip                Compress output using gzip (default: False)
  --bzip                Compress output using bzip2 (default: False)

The output is an interleaved set of reads, with each read in <R1> paired with a
read in <R2>. By default, the output goes to stdout unless `-o`/`--output` is
specified.

As a "bonus", this file ensures that if read names are not already formatted
properly, they are reformatted consistently, such that they look like the
pre-1.8 Casava format (`@name/1`, `@name/2`). This reformatting can be switched
off with the `--no-reformat` flag.

Example:

    interleave-reads.py tests/test-data/paired.fq.1 \
            tests/test-data/paired.fq.2 -o paired.fq
WARNING: Skipping mount /etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

|| This is the script interleave-reads.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_fastq-to-fasta.py

### Tool Description
Converts FASTQ format (.fq) files to FASTA format (.fa).

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: fastq-to-fasta.py [--version] [--info] [-h] [-o filename] [-n]
                         [--gzip | --bzip]
                         input_sequence

Converts FASTQ format (.fq) files to FASTA format (.fa).

positional arguments:
  input_sequence        The name of the input FASTQ sequence file.

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -o filename, --output filename
                        The name of the output FASTA sequence file. (default:
                        <_io.TextIOWrapper name='<stdout>' mode='w'
                        encoding='ANSI_X3.4-1968'>)
  -n, --n_keep          Option to keep reads containing 'N's in input_sequence
                        file. Default is to drop reads (default: False)
  --gzip                Compress output using gzip (default: False)
  --bzip                Compress output using bzip2 (default: False)
WARNING: Skipping mount /etc/resolv.conf [files]: /etc/resolv.conf doesn't exist in container

|| This is the script fastq-to-fasta.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_normalize-by-median.py

### Tool Description
Do digital normalization (remove mostly redundant sequences)

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: normalize-by-median.py [--version] [--info] [-h] [-k KSIZE]
                              [-U UNIQUE_KMERS] [--fp-rate FP_RATE]
                              [-M MAX_MEMORY_USAGE] [--small-count] [-q]
                              [-C CUTOFF] [-p] [--force_single]
                              [-u unpaired_reads_filename] [-s filename]
                              [-R report_filename]
                              [--report-frequency report_frequency] [-f]
                              [-o filename] [-l filename] [--gzip | --bzip]
                              input_sequence_filename
                              [input_sequence_filename ...]

Do digital normalization (remove mostly redundant sequences)

positional arguments:
  input_sequence_filename
                        Input FAST[AQ] sequence filename.

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -k KSIZE, --ksize KSIZE
                        k-mer size to use (default: 32)
  -U UNIQUE_KMERS, --unique-kmers UNIQUE_KMERS
                        approximate number of unique kmers in the input set
                        (default: 0)
  --fp-rate FP_RATE     Override the automatic FP rate setting for the current
                        script (default: None)
  -M MAX_MEMORY_USAGE, --max-memory-usage MAX_MEMORY_USAGE
                        maximum amount of memory to use for data structure
                        (default: None)
  --small-count         Reduce memory usage by using a smaller counter for
                        individual kmers. (default: False)
  -q, --quiet
  -C CUTOFF, --cutoff CUTOFF
                        when the median k-mer coverage level is above this
                        number the read is not kept. (default: 20)
  -p, --paired          require that all sequences be properly paired
                        (default: False)
  --force_single        treat all sequences as single-ended/unpaired (default:
                        False)
  -u unpaired_reads_filename, --unpaired-reads unpaired_reads_filename
                        include a file of unpaired reads to which -p/--paired
                        does not apply. (default: None)
  -s filename, --savegraph filename
                        save the k-mer countgraph to disk after all reads are
                        loaded. (default: None)
  -R report_filename, --report report_filename
                        write progress report to report_filename (default:
                        None)
  --report-frequency report_frequency
                        report progress every report_frequency reads (default:
                        100000)
  -f, --force           continue past file reading errors (default: False)
  -o filename, --output filename
                        only output a single file with the specified filename;
                        use a single dash "-" to specify that output should go
                        to STDOUT (the terminal) (default: None)
  -l filename, --loadgraph filename
                        load a precomputed k-mer graph from disk (default:
                        None)
  --gzip                Compress output using gzip (default: False)
  --bzip                Compress output using bzip2 (default: False)

Discard sequences based on whether or not their median k-mer abundance lies
above a specified cutoff. Kept sequences will be placed in <fileN>.keep.

By default, paired end reads will be considered together; if either read should
be kept, both will be kept. (This keeps both reads from a fragment, and helps
with retention of repeats.) Unpaired reads are treated individually.

If `-p`/`--paired` is set, then proper pairing is required and the script will
exit on unpaired reads, although `--unpaired-reads` can be used to supply a
file of orphan reads to be read after the paired reads.

`--force_single` will ignore all pairing information and treat reads
individually.

With `-s`/`--savegraph`, the k-mer countgraph will be saved to the specified
file after all sequences have been processed. `-l`/`--loadgraph` will load the
specified k-mer countgraph before processing the specified files.  Note that
these graphs are are in the same format as those produced by `load-into-
counting.py` and consumed by `abundance-dist.py`.

To append reads to an output file (rather than overwriting it), send output to
STDOUT with `--output -` and use UNIX file redirection syntax (`>>`) to append
to the file.

Example:

    normalize-by-median.py -k 17 tests/test-data/test-abund-read-2.fa

Example:

    normalize-by-median.py -p -k 17 \
    tests/test-data/test-abund-read-paired.fa

Example:

    normalize-by-median.py -p -k 17 -o - tests/test-data/paired.fq \
    >> appended-output.fq

Example:

    normalize-by-median.py -k 17 -f tests/test-data/test-error-reads.fq \
    tests/test-data/test-fastq-reads.fq

Example:

    normalize-by-median.py -k 17 -s test.ct \
    tests/test-data/test-abund-read-2.fa \
    tests/test-data/test-fastq-reads.fq

|| This is the script normalize-by-median.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||   * CT Brown et al., arXiv:1203.4802 [q-bio.GN]
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_load-into-counting.py

### Tool Description
Build a k-mer countgraph from the given sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: load-into-counting.py [--version] [--info] [-h] [-k KSIZE]
                             [-U UNIQUE_KMERS] [--fp-rate FP_RATE]
                             [-M MAX_MEMORY_USAGE] [--small-count]
                             [-T THREADS] [-b] [-s FORMAT] [-f] [-q]
                             output_countgraph_filename
                             input_sequence_filename
                             [input_sequence_filename ...]

Build a k-mer countgraph from the given sequences.

positional arguments:
  output_countgraph_filename
                        The name of the file to write the k-mer countgraph to.
  input_sequence_filename
                        The names of one or more FAST[AQ] input sequence
                        files.

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -k KSIZE, --ksize KSIZE
                        k-mer size to use (default: 32)
  -U UNIQUE_KMERS, --unique-kmers UNIQUE_KMERS
                        approximate number of unique kmers in the input set
                        (default: 0)
  --fp-rate FP_RATE     Override the automatic FP rate setting for the current
                        script (default: None)
  -M MAX_MEMORY_USAGE, --max-memory-usage MAX_MEMORY_USAGE
                        maximum amount of memory to use for data structure
                        (default: None)
  --small-count         Reduce memory usage by using a smaller counter for
                        individual kmers. (default: False)
  -T THREADS, --threads THREADS
                        Number of simultaneous threads to execute (default: 1)
  -b, --no-bigcount     The default behaviour is to count past 255 using
                        bigcount. This flag turns bigcount off, limiting
                        counts to 255. (default: True)
  -s FORMAT, --summary-info FORMAT
                        What format should the machine readable run summary be
                        in? (`json` or `tsv`, disabled by default) (default:
                        None)
  -f, --force           Overwrite output file if it exists (default: False)
  -q, --quiet

Note: with `-b`/`--no-bigcount` the output will be the exact size of the k-mer
countgraph and this script will use a constant amount of memory. In exchange
k-mer counts will stop at 255. The memory usage of this script with `-b` will
be about 1.15x the product of the `-x` and `-N` numbers.

Example:

    load-into-counting.py -k 20 -x 5e7 out data/100k-filtered.fa

Multiple threads can be used to accelerate the process, if you have extra cores
to spare.

Example:

    load-into-counting.py -k 20 -x 5e7 -T 4 out data/100k-filtered.fa

|| This is the script load-into-counting.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||   * Q Zhang et al., http://dx.doi.org/10.1371/journal.pone.0101271
||   * A. D\xf6ring et al. http://dx.doi.org:80/10.1186/1471-2105-9-11
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_abundance-dist.py

### Tool Description
Calculate abundance distribution of the k-mers in the sequence file using a pre-made k-mer countgraph.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: abundance-dist.py [--version] [--info] [-h] [-z] [-s] [-b] [-f] [-q]
                         input_count_graph_filename input_sequence_filename
                         output_histogram_filename

Calculate abundance distribution of the k-mers in the sequence file using a
pre-made k-mer countgraph.

positional arguments:
  input_count_graph_filename
                        The name of the input k-mer countgraph file.
  input_sequence_filename
                        The name of the input FAST[AQ] sequence file.
  output_histogram_filename
                        The columns are: (1) k-mer abundance, (2) k-mer count,
                        (3) cumulative count, (4) fraction of total distinct
                        k-mers.

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -z, --no-zero         Do not output zero-count bins (default: True)
  -s, --squash          Overwrite existing output_histogram_filename (default:
                        False)
  -b, --no-bigcount     Do not count k-mers past 255 (default: True)
  -f, --force           Continue even if specified input files do not exist or
                        are empty. (default: False)
  -q, --quiet

Example:

    load-into-counting.py -x 1e7 -N 2 -k 17 counts \
            tests/test-data/test-abund-read-2.fa
    abundance-dist.py counts tests/test-data/test-abund-read-2.fa test-dist

|| This is the script abundance-dist.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||   * Q Zhang et al., http://dx.doi.org/10.1371/journal.pone.0101271
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_abundance-dist-single.py

### Tool Description
Calculate the abundance distribution of k-mers from a single sequence file.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: abundance-dist-single.py [--version] [--info] [-h] [-k KSIZE]
                                [-U UNIQUE_KMERS] [--fp-rate FP_RATE]
                                [-M MAX_MEMORY_USAGE] [--small-count]
                                [-T THREADS] [-z] [-b] [-s]
                                [--savegraph filename] [-f] [-q]
                                input_sequence_filename
                                output_histogram_filename

Calculate the abundance distribution of k-mers from a single sequence file.

positional arguments:
  input_sequence_filename
                        The name of the input FAST[AQ] sequence file.
  output_histogram_filename
                        The name of the output histogram file. The columns
                        are: (1) k-mer abundance, (2) k-mer count, (3)
                        cumulative count, (4) fraction of total distinct
                        k-mers.

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -k KSIZE, --ksize KSIZE
                        k-mer size to use (default: 32)
  -U UNIQUE_KMERS, --unique-kmers UNIQUE_KMERS
                        approximate number of unique kmers in the input set
                        (default: 0)
  --fp-rate FP_RATE     Override the automatic FP rate setting for the current
                        script (default: None)
  -M MAX_MEMORY_USAGE, --max-memory-usage MAX_MEMORY_USAGE
                        maximum amount of memory to use for data structure
                        (default: None)
  --small-count         Reduce memory usage by using a smaller counter for
                        individual kmers. (default: False)
  -T THREADS, --threads THREADS
                        Number of simultaneous threads to execute (default: 1)
  -z, --no-zero         Do not output zero-count bins (default: True)
  -b, --no-bigcount     Do not count k-mers past 255 (default: True)
  -s, --squash          Overwrite output file if it exists (default: False)
  --savegraph filename  Save the k-mer countgraph to the specified filename.
                        (default: None)
  -f, --force           Override sanity checks (default: False)
  -q, --quiet

Note that with `-b`/`--no-bigcount` this script is constant memory; in
exchange, k-mer counts will stop at 255. The memory usage of this script with
`-b` will be about 1.15x the product of the `-x` and `-N` numbers.

To count k-mers in multiple files use `load_into_counting.py` and
`abundance_dist.py`.

Example:

    abundance-dist-single.py -x 1e7 -N 2 -k 17 \
            tests/test-data/test-abund-read-2.fa test-dist

|| This is the script abundance-dist-single.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||   * Q Zhang et al., http://dx.doi.org/10.1371/journal.pone.0101271
||   * A. D\xf6ring et al. http://dx.doi.org:80/10.1186/1471-2105-9-11
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_filter-abund-single.py

### Tool Description
Trims sequences at a minimum k-mer abundance (in memory version).

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: filter-abund-single.py [--version] [--info] [-h] [-k KSIZE]
                              [-U UNIQUE_KMERS] [--fp-rate FP_RATE]
                              [-M MAX_MEMORY_USAGE] [--small-count]
                              [-T THREADS] [-C CUTOFF] [-V] [-Z NORMALIZE_TO]
                              [--savegraph filename]
                              [-o optional_output_filename] [-f] [-q]
                              [--gzip | --bzip]
                              input_sequence_filename

Trims sequences at a minimum k-mer abundance (in memory version).

positional arguments:
  input_sequence_filename
                        FAST[AQ] sequence file to trim

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -k KSIZE, --ksize KSIZE
                        k-mer size to use (default: 32)
  -U UNIQUE_KMERS, --unique-kmers UNIQUE_KMERS
                        approximate number of unique kmers in the input set
                        (default: 0)
  --fp-rate FP_RATE     Override the automatic FP rate setting for the current
                        script (default: None)
  -M MAX_MEMORY_USAGE, --max-memory-usage MAX_MEMORY_USAGE
                        maximum amount of memory to use for data structure
                        (default: None)
  --small-count         Reduce memory usage by using a smaller counter for
                        individual kmers. (default: False)
  -T THREADS, --threads THREADS
                        Number of simultaneous threads to execute (default: 1)
  -C CUTOFF, --cutoff CUTOFF
                        Trim at k-mers below this abundance. (default: 2)
  -V, --variable-coverage
                        Only trim low-abundance k-mers from sequences that
                        have high coverage. (default: False)
  -Z NORMALIZE_TO, --normalize-to NORMALIZE_TO
                        Base the variable-coverage cutoff on this median k-mer
                        abundance. (default: 20)
  --savegraph filename  If present, the name of the file to save the k-mer
                        countgraph to (default: )
  -o optional_output_filename, --outfile optional_output_filename
                        Override default output filename and output trimmed
                        sequences into a file with the given filename.
                        (default: None)
  -f, --force           Overwrite output file if it exists (default: False)
  -q, --quiet
  --gzip                Compress output using gzip (default: False)
  --bzip                Compress output using bzip2 (default: False)

Trimmed sequences will be placed in "${input_sequence_filename}.abundfilt".

This script is constant memory.

To trim reads based on k-mer abundance across multiple files, use `load-into-
counting.py` and `filter-abund.py`.

Example:

    filter-abund-single.py -k 20 -x 5e7 -C 2 data/100k-filtered.fa

|| This is the script filter-abund-single.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||   * Q Zhang et al., http://dx.doi.org/10.1371/journal.pone.0101271
||   * A. D\xf6ring et al. http://dx.doi.org:80/10.1186/1471-2105-9-11
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_trim-low-abund.py

### Tool Description
Trim low-abundance k-mers using a streaming algorithm.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: trim-low-abund.py [--version] [--info] [-h] [-k KSIZE]
                         [-U UNIQUE_KMERS] [--fp-rate FP_RATE]
                         [-M MAX_MEMORY_USAGE] [--small-count] [-C CUTOFF]
                         [-Z TRIM_AT_COVERAGE] [-o output_filename] [-V]
                         [-l filename] [-s filename] [-q]
                         [--summary-info FORMAT] [--force] [--ignore-pairs]
                         [-T TEMPDIR] [--gzip | --bzip] [--diginorm]
                         [--diginorm-coverage DIGINORM_COVERAGE]
                         [--single-pass]
                         input_filenames [input_filenames ...]

Trim low-abundance k-mers using a streaming algorithm.

positional arguments:
  input_filenames

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -k KSIZE, --ksize KSIZE
                        k-mer size to use (default: 32)
  -U UNIQUE_KMERS, --unique-kmers UNIQUE_KMERS
                        approximate number of unique kmers in the input set
                        (default: 0)
  --fp-rate FP_RATE     Override the automatic FP rate setting for the current
                        script (default: None)
  -M MAX_MEMORY_USAGE, --max-memory-usage MAX_MEMORY_USAGE
                        maximum amount of memory to use for data structure
                        (default: None)
  --small-count         Reduce memory usage by using a smaller counter for
                        individual kmers. (default: False)
  -C CUTOFF, --cutoff CUTOFF
                        remove k-mers below this abundance (default: 2)
  -Z TRIM_AT_COVERAGE, --trim-at-coverage TRIM_AT_COVERAGE, --normalize-to TRIM_AT_COVERAGE
                        trim reads when entire read above this coverage
                        (default: 20)
  -o output_filename, --output output_filename
                        only output a single file with the specified filename;
                        use a single dash "-" to specify that output should go
                        to STDOUT (the terminal) (default: None)
  -V, --variable-coverage
                        Only trim low-abundance k-mers from sequences that
                        have high coverage. (default: False)
  -l filename, --loadgraph filename
                        load a precomputed k-mer graph from disk (default:
                        None)
  -s filename, --savegraph filename
                        save the k-mer countgraph to disk after allreads are
                        loaded. (default: )
  -q, --quiet
  --summary-info FORMAT
                        What format should the machine readable run summary be
                        in? (`json` or `tsv`, disabled by default) (default:
                        None)
  --force
  --ignore-pairs        treat all reads as if they were singletons (default:
                        False)
  -T TEMPDIR, --tempdir TEMPDIR
                        Set location of temporary directory for second pass
                        (default: ./)
  --gzip                Compress output using gzip (default: False)
  --bzip                Compress output using bzip2 (default: False)
  --diginorm            Eliminate high-coverage reads altogether (digital
                        normalization). (default: False)
  --diginorm-coverage DIGINORM_COVERAGE
                        Coverage threshold for --diginorm (default: 20)
  --single-pass         Do not do a second pass across the low coverage data
                        (default: False)

The output is one file for each input file, "<input file>.abundtrim", placed in
the current directory.  This output contains the input sequences trimmed at
low-abundance k-mers.

The `-V`/`--variable-coverage` parameter will, if specified, prevent
elimination of low-abundance reads by only trimming low-abundance k-mers from
high-abundance reads; use this for non-genomic data sets that may have variable
coverage.

Note that the output reads will not necessarily be in the same order as the
reads in the input files; if this is an important consideration, use `load-
into-counting.py` and `filter-abund.py`. However, read pairs will be kept
together, in "broken-paired" format; you can use `extract-paired-reads.py` to
extract read pairs and orphans.

Example:

    trim-low-abund.py -x 5e7 -k 20 -C 2 data/100k-filtered.fa

|| This is the script trim-low-abund.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||   * Q Zhang, S Awad, CT Brown, https://dx.doi.org/10.7287/peerj.preprints.890v1
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_count-median.py

### Tool Description
Count k-mers summary stats for sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: count-median.py [--version] [--info] [-h] [-f]
                       input_count_graph_filename input_sequence_filename
                       output_summary_filename

Count k-mers summary stats for sequences

positional arguments:
  input_count_graph_filename
                        input k-mer countgraph filename
  input_sequence_filename
                        input FAST[AQ] sequence filename
  output_summary_filename
                        output summary filename

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -f, --force           Overwrite output file if it exists (default: False)

Count the median/avg k-mer abundance for each sequence in the input file, based
on the k-mer counts in the given k-mer countgraph.  Can be used to estimate
expression levels (mRNAseq) or coverage (genomic/metagenomic).

The output file contains sequence id, median, average, stddev, and seq length,
in comma-separated value (CSV) format.

Example:

    load-into-counting.py counts tests/test-data/test-reads.fq.gz
    count-median.py counts tests/test-data/test-reads.fq.gz medians.txt

NOTE: All 'N's in the input sequences are converted to 'A's.

|| This is the script count-median.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_extract-paired-reads.py

### Tool Description
Take a mixture of reads and split into pairs and orphans.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: extract-paired-reads.py [--version] [--info] [-h] [-d OUTPUT_DIR]
                               [-p filename] [-s filename] [-f]
                               [--gzip | --bzip]
                               [infile]

Take a mixture of reads and split into pairs and orphans.

positional arguments:
  infile

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -d OUTPUT_DIR, --output-dir OUTPUT_DIR
                        Output split reads to specified directory. Creates
                        directory if necessary (default: )
  -p filename, --output-paired filename
                        Output paired reads to this file (default: None)
  -s filename, --output-single filename
                        Output orphaned reads to this file (default: None)
  -f, --force           Overwrite output file if it exists (default: False)
  --gzip                Compress output using gzip (default: False)
  --bzip                Compress output using bzip2 (default: False)

Many read-handling programs (assemblers, mappers, etc.) require that you give
them either perfectly interleaved files, or files containing only single reads.
This script takes files that were originally interleaved but where reads may
have been orphaned (via error filtering, application of abundance filtering,
digital normalization in non-paired mode, or partitioning) and separates the
interleaved reads from the orphaned reads.

The default output is two files, `<input file>.pe` and `<input file>.se`,
placed in the current directory. The .pe file contains interleaved and properly
paired sequences, while the .se file contains orphan sequences.

The directory into which the interleaved and orphaned reads are output may be
specified using `-d`/`--output-dir`. This directory will be created if it does
not already exist.

Alternatively, you can specify the filenames directly with `-p`/`--output-
paired` and `-s`/`--output-single`, which will override the `-d`/`--output-dir`
option.

Example:

    extract-paired-reads.py tests/test-data/paired.fq

|| This is the script extract-paired-reads.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_split-paired-reads.py

### Tool Description
Split interleaved reads into two files, left and right.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: split-paired-reads.py [--version] [--info] [-h] [-d output_directory]
                             [-0 output_orphaned] [-1 output_first]
                             [-2 output_second] [-f] [--gzip | --bzip]
                             [infile]

Split interleaved reads into two files, left and right.

positional arguments:
  infile

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -d output_directory, --output-dir output_directory
                        Output split reads to specified directory. Creates
                        directory if necessary (default: )
  -0 output_orphaned, --output-orphaned output_orphaned
                        Allow "orphaned" reads and extract them to this file
                        (default: None)
  -1 output_first, --output-first output_first
                        Output "left" reads to this file (default: None)
  -2 output_second, --output-second output_second
                        Output "right" reads to this file (default: None)
  -f, --force           Overwrite output file if it exists (default: False)
  --gzip                Compress output using gzip (default: False)
  --bzip                Compress output using bzip2 (default: False)

Some programs want paired-end read input in the One True Format, which is
interleaved; other programs want input in the Insanely Bad Format, with left-
and right- reads separated. This reformats the former to the latter.

The directory into which the left- and right- reads are output may be specified
using `-d`/`--output-dir`. This directory will be created if it does not
already exist.

Alternatively, you can specify the filenames directly with `-1`/`--output-
first` and `-2`/`--output-second`, which will override the `-d`/`--output-dir`
setting on a file-specific basis.

`-0`/'--output-orphans` will allow broken-paired format, and orphaned reads
will be saved separately, to the specified file.

Example:

    split-paired-reads.py tests/test-data/paired.fq

Example:

    split-paired-reads.py -0 reads-output-file tests/test-data/paired.fq

Example:

    split-paired-reads.py -1 reads.1 -2 reads.2 tests/test-data/paired.fq

|| This is the script split-paired-reads.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_sample-reads-randomly.py

### Tool Description
Uniformly subsample sequences from a collection of files

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: sample-reads-randomly.py [--version] [--info] [-h] [-N NUM_READS]
                                [-M MAX_READS] [-S NUM_SAMPLES]
                                [-R RANDOM_SEED] [--force_single]
                                [-o filename] [-f] [--gzip | --bzip]
                                filenames [filenames ...]

Uniformly subsample sequences from a collection of files

positional arguments:
  filenames

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -N NUM_READS, --num_reads NUM_READS
  -M MAX_READS, --max_reads MAX_READS
  -S NUM_SAMPLES, --samples NUM_SAMPLES
  -R RANDOM_SEED, --random-seed RANDOM_SEED
                        Provide a random seed for the generator (default:
                        None)
  --force_single        Ignore read pair information if present (default:
                        False)
  -o filename, --output filename
  -f, --force           Overwrite output file if it exits (default: False)
  --gzip                Compress output using gzip (default: False)
  --bzip                Compress output using bzip2 (default: False)

Take a list of files containing sequences, and subsample 100,000 sequences
(`-N`/`--num_reads`) uniformly, using reservoir sampling.  Stop after first
100m sequences (`-M`/`--max_reads`). By default take one subsample, but take
`-S`/`--samples` samples if specified.

The output is placed in `-o`/`--output` <file> (for a single sample) or in
"<file>.subset.0" to "<file>.subset.S-1" (for more than one sample).

This script uses the reservoir sampling algorithm.
http://en.wikipedia.org/wiki/Reservoir_sampling

|| This is the script sample-reads-randomly.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_extract-long-sequences.py

### Tool Description
Extract FASTQ or FASTA sequences longer than specified length (default: 200 bp).

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: extract-long-sequences.py [--version] [--info] [-h] [-o output]
                                 [-l LENGTH] [--gzip | --bzip]
                                 input_filenames [input_filenames ...]

Extract FASTQ or FASTA sequences longer than specified length (default: 200
bp).

positional arguments:
  input_filenames       Input FAST[AQ] sequence filename.

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -o output, --output output
                        The name of the output sequence file. (default:
                        <_io.TextIOWrapper name='<stdout>' mode='w'
                        encoding='ANSI_X3.4-1968'>)
  -l LENGTH, --length LENGTH
                        The minimum length of the sequence file. (default:
                        200)
  --gzip                Compress output using gzip (default: False)
  --bzip                Compress output using bzip2 (default: False)

Example:

    extract-long-sequences.py --length 10 tests/test-data/paired-mixed.fa

|| This is the script extract-long-sequences.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_readstats.py

### Tool Description
Display summary statistics for one or more FASTA/FASTQ files.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: readstats.py [--version] [--info] [-h] [-o filename] [--csv]
                    filenames [filenames ...]

Display summary statistics for one or more FASTA/FASTQ files.

positional arguments:
  filenames

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -o filename, --output filename
                        output file for statistics; defaults to stdout.
                        (default: <_io.TextIOWrapper name='<stdout>' mode='w'
                        encoding='ANSI_X3.4-1968'>)
  --csv                 Use the CSV format for the statistics, including
                        column headers. (default: False)

Report number of bases, number of sequences, and average sequence length for
one or more FASTA/FASTQ files; and report aggregate statistics at end.

With `-o`/`--output`, the output will be saved to the specified file.

Example:

    readstats.py tests/test-data/test-abund-read-2.fa

|| This is the script readstats.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_unique-kmers.py

### Tool Description
Estimate number of unique k-mers, with precision <= ERROR_RATE.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: unique-kmers.py [--version] [--info] [-h] [-q] [-k KSIZE]
                       [-e ERROR_RATE] [-R filename] [-S] [--diagnostics]
                       input_sequence_filename [input_sequence_filename ...]

Estimate number of unique k-mers, with precision <= ERROR_RATE.

positional arguments:
  input_sequence_filename
                        Input FAST[AQ] sequence filename(s).

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -q, --quiet
  -k KSIZE, --ksize KSIZE
                        k-mer size to use (default: 32)
  -e ERROR_RATE, --error-rate ERROR_RATE
                        Acceptable error rate (default: 0.01)
  -R filename, --report filename
                        generate informational report and write to filename
                        (default: None)
  -S, --stream-records  write input sequences to STDOUT (default: False)
  --diagnostics         print out recommended tablesize arguments and
                        restrictions (default: False)

A HyperLogLog counter is used to do cardinality estimation. Since this counter
is based on a tradeoff between precision and memory consumption, the
`-e`/`--error-rate` can be used to control how much memory will be used. In
practice the memory footprint is small even at low error rates (< 0.01).

`-k`/`--ksize` should be set to the desired k-mer size.

Informational output is sent to STDERR, but a report file can be generated with
`-R`/`--report`.

`--stream-records` will write the sequences taken in to STDOUT. This is useful
for workflows: count unique kmers in a stream, then do digital normalization.

`--diagnostics` will provide detailed options for tablesize and memory
limitations for various false positive rates. This is useful for configuring
other khmer scripts. This will be written to STDERR.

Example:

    unique-kmers.py -k 17 tests/test-data/test-abund-read{,-2,-3}.fa

Example:

    unique-kmers.py -k 17 --diagnostics tests/test-data/test-abund-read.fa

Example:

    unique-kmers.py --stream-records -k 17 tests/test-data/test-reads.fa | \
    normalize-by-median.py -k 17 -o normalized /dev/stdin

Example:

    unique-kmers.py -R unique_count -k 30 \
    tests/test-data/test-abund-read-paired.fa

|| This is the script unique-kmers.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||   * A. D\xf6ring et al. http://dx.doi.org:80/10.1186/1471-2105-9-11
||   * Irber and Brown. http://dx.doi.org/10.1101/056846
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_load-graph.py

### Tool Description
Load sequences into the compressible graph format plus optional tagset.

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: load-graph.py [--version] [--info] [-h] [-k KSIZE] [-U UNIQUE_KMERS]
                     [--fp-rate FP_RATE] [-M MAX_MEMORY_USAGE] [-T THREADS]
                     [--no-build-tagset] [-f]
                     output_nodegraph_filename input_sequence_filename
                     [input_sequence_filename ...]

Load sequences into the compressible graph format plus optional tagset.

positional arguments:
  output_nodegraph_filename
                        output k-mer nodegraph filename.
  input_sequence_filename
                        input FAST[AQ] sequence filename

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -k KSIZE, --ksize KSIZE
                        k-mer size to use (default: 32)
  -U UNIQUE_KMERS, --unique-kmers UNIQUE_KMERS
                        approximate number of unique kmers in the input set
                        (default: 0)
  --fp-rate FP_RATE     Override the automatic FP rate setting for the current
                        script (default: None)
  -M MAX_MEMORY_USAGE, --max-memory-usage MAX_MEMORY_USAGE
                        maximum amount of memory to use for data structure
                        (default: None)
  -T THREADS, --threads THREADS
                        Number of simultaneous threads to execute (default: 1)
  --no-build-tagset, -n
                        Do NOT construct tagset while loading sequences
                        (default: False)
  -f, --force           Overwrite output file if it exists (default: False)

|| This is the script load-graph.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||   * J Pell et al., http://dx.doi.org/10.1073/pnas.1121464109
||   * A. D\xf6ring et al. http://dx.doi.org:80/10.1186/1471-2105-9-11
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
## khmer_do-partition.py

### Tool Description
Load, partition, and annotate FAST[AQ] sequences

### Metadata
- **Docker Image**: quay.io/biocontainers/khmer:3.0.0a1--py36hfc679d8_0
- **Homepage**: https://khmer.readthedocs.io/
- **Package**: https://anaconda.org/channels/bioconda/packages/khmer/overview
- **Validation**: PASS

### Original Help Text
```text
usage: do-partition.py [--version] [--info] [-h] [-k KSIZE] [-U UNIQUE_KMERS]
                       [--fp-rate FP_RATE] [-M MAX_MEMORY_USAGE] [-T THREADS]
                       [-s SUBSET_SIZE] [--no-big-traverse] [--keep-subsets]
                       [-f]
                       graphbase input_sequence_filename
                       [input_sequence_filename ...]

Load, partition, and annotate FAST[AQ] sequences

positional arguments:
  graphbase             base name for output files
  input_sequence_filename
                        input FAST[AQ] sequence filenames

optional arguments:
  --version             show program's version number and exit
  --info                print citation information
  -h, --help            show this help message and exit
  -k KSIZE, --ksize KSIZE
                        k-mer size to use (default: 32)
  -U UNIQUE_KMERS, --unique-kmers UNIQUE_KMERS
                        approximate number of unique kmers in the input set
                        (default: 0)
  --fp-rate FP_RATE     Override the automatic FP rate setting for the current
                        script (default: None)
  -M MAX_MEMORY_USAGE, --max-memory-usage MAX_MEMORY_USAGE
                        maximum amount of memory to use for data structure
                        (default: None)
  -T THREADS, --threads THREADS
                        Number of simultaneous threads to execute (default: 1)
  -s SUBSET_SIZE, --subset-size SUBSET_SIZE
                        Set subset size (usually 1e5-1e6 is good) (default:
                        100000)
  --no-big-traverse     Truncate graph joins at big traversals (default:
                        False)
  --keep-subsets        Keep individual subsets (default: False)
  -f, --force           Overwrite output file if it exists (default: False)

Load in a set of sequences, partition them, merge the partitions, and annotate
the original sequences files with the partition information.

This script combines the functionality of `load-graph.py`, `partition-
graph.py`, `merge-partitions.py`, and `annotate-partitions.py` into one script.
This is convenient but should probably not be used for large data sets, because
`do-partition.py` doesn't provide save/resume functionality.

Example:

    do-partition.py -k 20 example tests/test-data/random-20-a.fa

|| This is the script do-partition.py in khmer.
|| You are running khmer version 3.0.0a1
|| You are also using screed version 1.0
||
|| If you use this script in a publication, please cite EACH of the following:
||
||   * MR Crusoe et al., 2015. http://dx.doi.org/10.12688/f1000research.6924.1
||   * J Pell et al., http://dx.doi.org/10.1073/pnas.1121464109
||
|| Please see http://khmer.readthedocs.io/en/latest/citations.html for details.
```
