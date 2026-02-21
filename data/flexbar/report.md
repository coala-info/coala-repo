# flexbar CWL Generation Report

## flexbar

### Tool Description
The program Flexbar preprocesses high-throughput sequencing data efficiently. It demultiplexes barcoded runs and removes adapter sequences.

### Metadata
- **Docker Image**: quay.io/biocontainers/flexbar:3.5.0--hdfd68b8_12
- **Homepage**: https://github.com/seqan/flexbar
- **Package**: https://anaconda.org/channels/bioconda/packages/flexbar/overview
- **Validation**: PASS

- **Conda**: https://anaconda.org/channels/bioconda/packages/flexbar/overview
- **Total Downloads**: 23.6K
- **Last updated**: 2025-06-26
- **GitHub**: https://github.com/seqan/flexbar
- **Stars**: N/A
### Original Help Text
```text
flexbar - flexible barcode and adapter removal
==============================================

SYNOPSIS
    flexbar -r reads [-b barcodes] [-a adapters] [options]

DESCRIPTION
    The program Flexbar preprocesses high-throughput sequencing data
    efficiently. It demultiplexes barcoded runs and removes adapter sequences.
    Several adapter removal presets for Illumina libraries are included.
    Flexbar computes exact overlap alignments using SIMD and multicore
    parallelism. Moreover, trimming and filtering features are provided, e.g.
    trimming of homopolymers at read ends. Flexbar increases read mapping
    rates and improves genome as well as transcriptome assemblies. Unique
    molecular identifiers can be extracted in a flexible way. The software
    supports data in fasta and fastq format from multiple sequencing
    platforms. Refer to the manual on github.com/seqan/flexbar/wiki or contact
    Johannes Roehr on github.com/jtroehr for support with this application.

OPTIONS
    -h, --help
          Display the help message.
    -hh, --full-help
          Display the help message with advanced options.
    -v, --versions
          Print Flexbar and SeqAn version numbers.
    -c, --cite
          Show program references for citation.

  Basic options:
    -n, --threads INTEGER
          Number of threads to employ. Default: 1.
    -t, --target OUTPUT_PREFIX
          Prefix for output file names or paths. Default: flexbarOut.
    -r, --reads INPUT_FILE
          Fasta/q file or stdin (-) with reads that may contain barcodes.
    -p, --reads2 INPUT_FILE
          Second input file of paired reads, gz and bz2 files supported.

  Barcode detection:
    -b, --barcodes INPUT_FILE
          Fasta file with barcodes for demultiplexing, may contain N.
    -br, --barcode-reads INPUT_FILE
          Fasta/q file containing separate barcode reads for detection.
    -bo, --barcode-min-overlap INTEGER
          Minimum overlap of barcode and read. Default: barcode length.
    -be, --barcode-error-rate DOUBLE
          Error rate threshold for mismatches and gaps. Default: 0.0.
    -bt, --barcode-trim-end STRING
          Type of detection, see section trim-end modes. Default: LTAIL.

  Adapter removal:
    -a, --adapters INPUT_FILE
          Fasta file with adapters for removal that may contain N.
    -a2, --adapters2 INPUT_FILE
          File with extra adapters for second read set in paired mode.
    -aa, --adapter-preset STRING
          One of TruSeq, SmallRNA, Methyl, Ribo, Nextera, and NexteraMP.
    -ao, --adapter-min-overlap INTEGER
          Minimum overlap for removal without pair overlap. Default: 3.
    -ae, --adapter-error-rate DOUBLE
          Error rate threshold for mismatches and gaps. Default: 0.1.
    -at, --adapter-trim-end STRING
          Type of removal, see section trim-end modes. Default: RIGHT.
    -ap, --adapter-pair-overlap STRING
          Overlap detection of paired reads. One of ON, SHORT, and ONLY.

  Filtering and trimming:
    -u, --max-uncalled INTEGER
          Allowed uncalled bases N for each read. Default: 0.
    -x, --pre-trim-left INTEGER
          Trim given number of bases on 5' read end before detection.
    -y, --pre-trim-right INTEGER
          Trim specified number of bases on 3' end prior to detection.
    -m, --min-read-length INTEGER
          Minimum read length to remain after removal. Default: 18.

  Quality-based trimming:
    -q, --qtrim STRING
          Quality-based trimming mode. One of TAIL, WIN, and BWA.
    -qf, --qtrim-format STRING
          Quality format. One of sanger, solexa, i1.3, i1.5, and i1.8.
    -qt, --qtrim-threshold INTEGER
          Minimum quality as threshold for trimming. Default: 20.

  Trimming of homopolymers:
    -hr, --htrim-right STRING
          Trim certain homopolymers on right read end after removal.
    -hi, --htrim-min-length INTEGER
          Minimum length of homopolymers at read ends. Default: 3.
    -he, --htrim-error-rate DOUBLE
          Error rate threshold for mismatches. Default: 0.1.

  Output selection:
    -f, --fasta-output
          Prefer non-quality format fasta for output.
    -z, --zip-output STRING
          Direct compression of output files. One of GZ and BZ2.
    -1, --stdout-reads
          Write reads to stdout, tagged and interleaved if needed.

  Logging and tagging:
    -l, --align-log STRING
          Print chosen read alignments. One of ALL, MOD, and TAB.
    -o, --stdout-log
          Write statistics to stdout instead of target log file.
    -g, --removal-tags
          Tag reads that are subject to adapter or barcode removal.

TRIM-END MODES
    ANY: longer side of read remains after removal of overlap
    LEFT: right side remains after removal, align <= read end
    RIGHT: left part remains after removal, align >= read start
    LTAIL: consider first n bases of reads in alignment
    RTAIL: use only last n bases, see tail-length options

EXAMPLES
    flexbar -r reads.fq -t target -q TAIL -qf i1.8
    flexbar -r reads.fq -b barcodes.fa -bt LTAIL
    flexbar -r reads.fq -a adapters.fa -ao 3 -ae 0.1
    flexbar -r r1.fq -p r2.fq -a a1.fa -a2 a2.fa -ap ON
    flexbar -r r1.fq -p r2.fq -aa TruSeq -ap ON

VERSION
    Last update: May 2019
    flexbar version: 3.5.0
    SeqAn version: 2.4.0

Available on github.com/seqan/flexbar

Show advanced options: flexbar -hh
```


## Metadata
- **Skill**: generated
