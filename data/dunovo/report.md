# dunovo CWL Generation Report

## dunovo_make-families.sh

### Tool Description
Read raw duplex sequencing reads, extract their barcodes, and group them by barcode.
Input fastq's can be gzipped.

### Metadata
- **Docker Image**: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
- **Homepage**: https://github.com/galaxyproject/dunovo
- **Package**: https://anaconda.org/channels/bioconda/packages/dunovo/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/dunovo/overview
- **Total Downloads**: 72.8K
- **Last updated**: 2025-04-22
- **GitHub**: https://github.com/galaxyproject/dunovo
- **Stars**: N/A
### Original Help Text
```text
Usage: $ make-families.sh [-t tag_len] [-i invariant_len] reads_1.fq reads_2.fq > families.tsv
Read raw duplex sequencing reads, extract their barcodes, and group them by barcode.
Input fastq's can be gzipped.
-t: The length of the barcode portion of each read. Default: 12
-i: The length of the invariant (ligation) portion of each read. Default: 5
-S: The memory usage parameter to pass directly to the sort command's -S option.
    Can be an absolute figure like 5G or a percentage. See man sort for details.
-T: The temporary file directory that sort should use.
    Will be passed directly to the sort command's -T option.
```


## dunovo_baralign.sh

### Tool Description
Aligns barcodes to a reference genome.

### Metadata
- **Docker Image**: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
- **Homepage**: https://github.com/galaxyproject/dunovo
- **Package**: https://anaconda.org/channels/bioconda/packages/dunovo/overview
- **Validation**: PASS

### Original Help Text
```text
Usage: $ baralign.sh [options] families.tsv [refdir [outfile.sam|outfile.bam]]
families.tsv: The families file produced by make-barcodes.awk and sorted.
refdir:  The directory to put the reference file ("barcodes.fa") and its index
         files in. Default: "refdir".
outfile: Print the output to this path. It will be in SAM format unless the
         path ends in ".bam". If not given, it will be printed to stdout
         in SAM format.
-R: Don't include reversed barcodes (alpha+beta -> beta+alpha) in the alignment
    target.
-t: Number of threads for bowtie and bowtie-build to use (default: 1).
-c: Number to pass to bowtie's --chunkmbs option (default: 512).
-p: Report helpful usage data to the developer, to better understand the use
    cases and performance of the tool. The only data which will be recorded is
    the name and version of the tool, the size of the input data, the time taken
    to process it, the IP address of the machine running it, and some
    performance-related parameters (-t, -c, and the format of the output file).
    No filenames are sent. All the reporting and recording code is available at
    https://github.com/NickSto/ET.
-g: Report the platform as "galaxy" when sending usage data.
-v: Print the version number and exit.
-q: Quiet mode

Error: Must provide an input families.tsv file.
```


## dunovo_correct.py

### Tool Description
Correct barcodes using an alignment of all barcodes to themselves. Reads the alignment in SAM format and corrects the barcodes in an input "families" file (the output of make-barcodes.awk). It will print the "families" file to stdout with barcodes (and orders) corrected.

### Metadata
- **Docker Image**: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
- **Homepage**: https://github.com/galaxyproject/dunovo
- **Package**: https://anaconda.org/channels/bioconda/packages/dunovo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: $ correct.py [options] families.tsv barcodes.fa barcodes.sam > families.corrected.tsv

Correct barcodes using an alignment of all barcodes to themselves. Reads the
alignment in SAM format and corrects the barcodes in an input "families" file
(the output of make-barcodes.awk). It will print the "families" file to stdout
with barcodes (and orders) corrected.

positional arguments:
  families              The sorted output of make-barcodes.awk. The important
                        part is that it's a tab-delimited file with at least 2
                        columns: the barcode sequence and order, and it must
                        be sorted in the same order as the "reads" in the SAM
                        file.
  reads                 The fasta/q file given to the aligner. Used to get
                        barcode sequences from read names.
  sam                   Barcode alignment, in SAM format. Omit to read from
                        stdin. The read names must be integers, representing
                        the (1-based) order they appear in the families file.

optional arguments:
  -h, --help            show this help message and exit
  -P, --prepend         Prepend the corrected barcodes and orders to the
                        original columns.
  -d DIST, --dist DIST  NM edit distance threshold. Default: 3
  -m MAPQ, --mapq MAPQ  MAPQ threshold. Default: 20
  -p POS, --pos POS     POS tolerance. Alignments will be ignored if abs(POS -
                        1) is greater than this value. Set to greater than the
                        barcode length for no threshold. Default: 2
  -c {count,connect}, --choose-by {count,connect}
                        Choose the "correct" barcode in a network of related
                        barcodes by either the count of how many times the
                        barcode was observed ('count') or how connected the
                        barcode is to the others in the network ('connect').
                        Default: count
  -N, --allow-no-nm-if-ns
                        Allow alignments with missing NM tags if the barcode
                        has at least one N. Otherwise this will fail if it
                        encounters an alignment missing an NM tag.
  -I, --no-check-ids    Don't check to make sure read pairs have identical
                        ids. By default, if this encounters a pair of reads in
                        families.tsv with ids that aren't identical (minus an
                        ending /1 or /2), it will throw an error.
  --limit LIMIT         Limit the number of entries that will be read from
                        each input file, for testing purposes.
  -S, --structures      Print a list of the unique isoforms
  --struct-human
  -V [networks.png], --visualize [networks.png]
                        Produce a visualization of the unique structures and
                        write the image to this file. If you omit a filename,
                        it will be displayed in a window.
  -F {dot,graphviz,png}, --viz-format {dot,graphviz,png}
  -n, --no-output
  -l LOG, --log LOG     Print log messages to this file instead of to stderr.
                        Warning: Will overwrite the file.
  -q, --quiet
  -i, --info
  -v, --verbose
  -D, --debug           Print debug messages (very verbose).
  --phone-home          Report helpful usage data to the developer, to better
                        understand the use cases and performance of the tool.
                        The only data which will be recorded is the name and
                        version of the tool, the size of the input data, the
                        time and memory taken to process it, and the IP
                        address of the machine running it. Also, if the script
                        fails, it will report the name of the exception thrown
                        and the line of code it occurred in. No parameters or
                        filenames are sent. All the reporting and recording
                        code is available at https://github.com/NickSto/ET.
  --galaxy              Tell the script it's running on Galaxy. Currently this
                        only affects data reported when phoning home.
  --test                If reporting usage data, mark this as a test run.
  --version             Print the version number and exit.
```


## dunovo_align-families.py

### Tool Description
Read in sorted FASTQ data and do multiple sequence alignments of each family.

### Metadata
- **Docker Image**: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
- **Homepage**: https://github.com/galaxyproject/dunovo
- **Package**: https://anaconda.org/channels/bioconda/packages/dunovo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: $ align-families.py [options] families.tsv > families.msa.tsv
       $ cat families.tsv | align-families.py [options] > families.msa.tsv

Read in sorted FASTQ data and do multiple sequence alignments of each
family.

positional arguments:
  read-families.tsv     The input reads, sorted into families. One
                        line per read pair, 8 tab-delimited columns:
                        1. canonical barcode
                        2. barcode order ("ab" for alpha+beta, "ba"
                        for beta-alpha)
                        3. read 1 name
                        4. read 1 sequence
                        5. read 1 quality scores
                        6. read 2 name
                        7. read 2 sequence
                        8. read 2 quality scores

optional arguments:
  -h, --help            show this help message and exit
  -a {mafft,kalign,dummy}, --aligner {mafft,kalign,dummy}
                        The multiple sequence aligner to use. Default:
                        kalign
  -I, --no-check-ids    Don't check to make sure read pairs have
                        identical ids. By default, if this encounters
                        a pair of reads in families.tsv with ids that
                        aren't identical (minus an ending /1 or /2),
                        it will throw an error.
  -p PROCESSES, --processes PROCESSES
                        Number of worker subprocesses to use. If 0, no
                        subprocesses will be started and everything
                        will be done inside one process. Give "auto"
                        to use as many processes as there are CPU
                        cores. Default: 0.
  --queue-size QUEUE_SIZE
                        How long to go accumulating responses from
                        worker subprocesses before dealing with all of
                        them. Default: 8 * the number of worker
                        --processes.
  --phone-home          Report helpful usage data to the developer, to
                        better understand the use cases and
                        performance of the tool. The only data which
                        will be recorded is the name and version of
                        the tool, the size of the input data, the time
                        and memory taken to process it, and the IP
                        address of the machine running it. Also, if
                        the script fails, it will report the name of
                        the exception thrown and the line of code it
                        occurred in. No filenames are sent, and the
                        only parameters reported are --aligner,
                        --processes, and --queue-size, which are
                        necessary to evaluate performance. All the
                        reporting and recording code is available at
                        https://github.com/NickSto/ET.
  --galaxy              Tell the script it's running on Galaxy.
                        Currently this only affects data reported when
                        phoning home.
  --test                If reporting usage data, mark this as a test
                        run.
  --version             Print the version number and exit.
  -L LOG_FILE, --log-file LOG_FILE
                        Print log messages to this file instead of to
                        stderr. NOTE: Will overwrite the file.
  -q, --quiet
  -v, --verbose
  -D, --debug
```


## dunovo_make-consensi.py

### Tool Description
Build consensus sequences from read aligned families. Prints duplex consensus sequences in FASTA to stdout. The sequence ids are BARCODE.MATE, e.g. "CTCAGATAACATACCTTATATGCA.1", where "BARCODE" is the input barcode, and "MATE" is "1" or "2" as an arbitrary designation of the two reads in the pair. The id is followed by the count of the number of reads in the two families (one from each strand) that make up the duplex, in the format READS1/READS2. If the duplex is actually a single-strand consensus because the matching strand is missing, only one number is listed.
Rules for consensus building: Single-strand consensus sequences are made by counting how many of each base are at a given position. Bases with a PHRED quality score below the --qual threshold are not counted. If a majority of the reads (that pass the --qual threshold at that position) have one base at that position, then that base is used as the consensus base. If no base has a majority, then an N is used.
Duplex consensus sequences are made by aligning pairs of single-strand consensuses, and comparing bases at each position. If they agree, that base is used in the consensus. Otherwise, the IUPAC ambiguity code for both bases is used (N + anything and gap + non-gap result in an N).

### Metadata
- **Docker Image**: quay.io/biocontainers/dunovo:3.0.2--h7b50bb2_4
- **Homepage**: https://github.com/galaxyproject/dunovo
- **Package**: https://anaconda.org/channels/bioconda/packages/dunovo/overview
- **Validation**: PASS

### Original Help Text
```text
usage: $ make-consensi.py [options] families.msa.tsv -1 duplexes_1.fa -2 duplexes_2.fa
       $ cat families.msa.tsv | make-consensi.py [options] -1 duplexes_1.fa -2 duplexes_2.fa

Build consensus sequences from read aligned families. Prints duplex
consensus sequences in FASTA to stdout. The sequence ids are
BARCODE.MATE, e.g. "CTCAGATAACATACCTTATATGCA.1", where "BARCODE" is
the input barcode, and "MATE" is "1" or "2" as an arbitrary
designation of the two reads in the pair. The id is followed by the
count of the number of reads in the two families (one from each
strand) that make up the duplex, in the format READS1/READS2. If the
duplex is actually a single-strand consensus because the matching
strand is missing, only one number is listed.
Rules for consensus building: Single-strand consensus sequences are
made by counting how many of each base are at a given position. Bases
with a PHRED quality score below the --qual threshold are not counted.
If a majority of the reads (that pass the --qual threshold at that
position) have one base at that position, then that base is used as
the consensus base. If no base has a majority, then an N is used.
Duplex consensus sequences are made by aligning pairs of single-strand
consensuses, and comparing bases at each position. If they agree, that
base is used in the consensus. Otherwise, the IUPAC ambiguity code for
both bases is used (N + anything and gap + non-gap result in an N).

Inputs and outputs:
  families.msa.tsv      The output of align_families.py. 6 columns:
                        1. (canonical) barcode
                        2. order ("ab" or "ba")
                        3. mate ("1" or "2")
                        4. read name
                        5. aligned sequence
                        6. aligned quality scores.
  -1 duplex_1.fa, --dcs1 duplex_1.fa
                        The file to output the first mates of the
                        duplex consensus sequences into. Warning: This
                        will be overwritten if it exists!
  -2 duplex_2.fa, --dcs2 duplex_2.fa
                        Same, but for mate 2.
  --sscs1 sscs_1.fa     Save the single-strand consensus sequences
                        (mate 1) in this file (FASTA format). Warning:
                        This will be overwritten if it exists!
  --sscs2 sscs_2.fa     Save the single-strand consensus sequences
                        (mate 2) in this file (FASTA format). Warning:
                        This will be overwritten if it exists!
  -F {sanger,solexa}, --qual-format {sanger,solexa}
                        FASTQ quality score format. Sanger scores are
                        assumed to begin at 33 ('!'). Default:
                        sanger.
  --fastq-out PHRED_SCORE
                        Output in FASTQ instead of FASTA. You must
                        specify the quality score to give to all
                        bases. There is no meaningful quality score we
                        can automatically give, so you will have to
                        specify an artificial one. A good choice is
                        40, the maximum score normally output by
                        sequencers.

Algorithm parameters:
  -r MIN_READS, --min-reads MIN_READS
                        The minimum number of reads (from each strand)
                        required to form a single-strand consensus.
                        Strands with fewer reads will be skipped.
                        Default: 3.
  -q PHRED_SCORE, --qual PHRED_SCORE
                        Base quality threshold. Bases below this
                        quality will not be counted. Default:
                        20.
  -c THRES, --cons-thres THRES
                        The fractional threshold to use when making
                        consensus sequences. The consensus base must
                        be present in more than this fraction of the
                        reads, or N will be used as the consensus base
                        instead. Default: 0.7
  -C MIN_CONS_READS, --min-cons-reads MIN_CONS_READS
                        The absolute threshold to use when making
                        consensus sequences. The consensus base must
                        be present in more than this number of reads,
                        or N will be used as the consensus base
                        instead. Default: 0
  -a {swalign,biopython}, --aligner {swalign,biopython}
                        Which pairwise alignment library to use.
                        'swalign' uses a custom Smith-Waterman
                        implementation by Nicolaus Lance Hepler and is
                        the old default. 'biopython' uses BioPython's
                        PairwiseAligner and a substitution matrix
                        built by the Bioconductor's Biostrings
                        package. Default: biopython

Feedback:
  --phone-home          Report helpful usage data to the developer, to
                        better understand the use cases and
                        performance of the tool. The only data which
                        will be recorded is the name and version of
                        the tool, the size of the input data, the time
                        and memory taken to process it, and the IP
                        address of the machine running it. Also, if
                        the script fails, it will report the name of
                        the exception thrown and the line of code it
                        occurred in. No filenames are sent, and the
                        only parameters reported are the number of
                        --processes and the --queue-size. All the
                        reporting and recording code is available at
                        https://github.com/NickSto/ET.
  --galaxy              Tell the script it's running on Galaxy.
                        Currently this only affects data reported when
                        phoning home.
  --test                If reporting usage data, mark this as a test
                        run.

Logging:
  -l LOG, --log LOG     Print log messages to this file instead of to
                        stderr. Warning: Will overwrite the file.
  -Q, --quiet
  -V, --verbose
  -D, --debug

Miscellaneous:
  -p PROCESSES, --processes PROCESSES
                        Number of worker subprocesses to use. If 0, no
                        subprocesses will be started and everything
                        will be done inside one process. Give "auto"
                        to use as many processes as there are CPU
                        cores. Default: 0.
  --queue-size QUEUE_SIZE
                        How long to go accumulating responses from
                        worker subprocesses before dealing with all of
                        them. Default: 8 * the number of worker
                        --processes.
  -v, --version         Print the version number and exit.
  -h, --help            Print this text on usage and arguments.
```


## Metadata
- **Skill**: generated
