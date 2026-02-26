cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge
label: centrifuge-core_centrifuge
doc: "Centrifuge version 1.0.4 by the Centrifuge developer team (centrifuge.metagenomics@gmail.com)\n\
  \nTool homepage: https://github.com/infphilo/centrifuge"
inputs:
  - id: exclude_taxids
    type:
      - 'null'
      - string
    doc: comma-separated list of taxonomic IDs that will be excluded in 
      classification
    inputBinding:
      position: 101
      prefix: --exclude-taxids
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: query input files are (multi-)FASTA .fa/.mfa
    inputBinding:
      position: 101
      prefix: -f
  - id: fastq
    type:
      - 'null'
      - boolean
    doc: query input files are FASTQ .fq/.fastq (default)
    inputBinding:
      position: 101
      prefix: -q
  - id: host_taxids
    type:
      - 'null'
      - string
    doc: comma-separated list of taxonomic IDs that will be preferred in 
      classification
    inputBinding:
      position: 101
      prefix: --host-taxids
  - id: ignore_quals
    type:
      - 'null'
      - boolean
    doc: treat all quality values as 30 on Phred scale (off)
    inputBinding:
      position: 101
      prefix: --ignore-quals
  - id: index_prefix
    type: string
    doc: Index filename prefix (minus trailing .X.cf).
    inputBinding:
      position: 101
      prefix: -x
  - id: int_quals
    type:
      - 'null'
      - boolean
    doc: qualities encoded as space-delimited integers
    inputBinding:
      position: 101
      prefix: --int-quals
  - id: mates1
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files with #1 mates, paired with files in <m2>.\n             Could be gzip'ed
      (extension: .gz) or bzip2'ed (extension: .bz2)."
    inputBinding:
      position: 101
      prefix: '-1'
  - id: mates2
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files with #2 mates, paired with files in <m1>.\n             Could be gzip'ed
      (extension: .gz) or bzip2'ed (extension: .bz2)."
    inputBinding:
      position: 101
      prefix: '-2'
  - id: max_assignments
    type:
      - 'null'
      - int
    doc: report upto <int> distinct, primary assignments for each read or pair
    inputBinding:
      position: 101
      prefix: -k
  - id: memory_mapped_io
    type:
      - 'null'
      - boolean
    doc: use memory-mapped I/O for index; many instances can share
    inputBinding:
      position: 101
      prefix: --mm
  - id: metrics_interval
    type:
      - 'null'
      - int
    doc: report internal counters & metrics every <int> secs (1)
    default: 1
    inputBinding:
      position: 101
      prefix: --met
  - id: metrics_stderr
    type:
      - 'null'
      - boolean
    doc: send metrics to stderr (off)
    inputBinding:
      position: 101
      prefix: --met-stderr
  - id: min_hitlen
    type:
      - 'null'
      - int
    doc: minimum length of partial hits (default 22, must be greater than 15)
    inputBinding:
      position: 101
      prefix: --min-hitlen
  - id: nofw
    type:
      - 'null'
      - boolean
    doc: do not align forward (original) version of read (off)
    inputBinding:
      position: 101
      prefix: --nofw
  - id: non_deterministic_seed
    type:
      - 'null'
      - boolean
    doc: seed rand. gen. arbitrarily instead of using read attributes
    inputBinding:
      position: 101
      prefix: --non-deterministic
  - id: norc
    type:
      - 'null'
      - boolean
    doc: do not align reverse-complement version of read (off)
    inputBinding:
      position: 101
      prefix: --norc
  - id: output_format
    type:
      - 'null'
      - string
    doc: define output format, either 'tab' or 'sam' (tab)
    default: tab
    inputBinding:
      position: 101
      prefix: --out-fmt
  - id: phred33
    type:
      - 'null'
      - boolean
    doc: qualities are Phred+33 (default)
    inputBinding:
      position: 101
      prefix: --phred33
  - id: phred64
    type:
      - 'null'
      - boolean
    doc: qualities are Phred+64
    inputBinding:
      position: 101
      prefix: --phred64
  - id: qc_filter
    type:
      - 'null'
      - boolean
    doc: filter out reads that are bad according to QSEQ filter
    inputBinding:
      position: 101
      prefix: --qc-filter
  - id: qseq
    type:
      - 'null'
      - boolean
    doc: query input files are in Illumina's qseq format
    inputBinding:
      position: 101
      prefix: --qseq
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: print nothing to stderr except serious errors
    inputBinding:
      position: 101
      prefix: --quiet
  - id: raw
    type:
      - 'null'
      - boolean
    doc: query input files are raw one-sequence-per-line
    inputBinding:
      position: 101
      prefix: -r
  - id: sample_sheet
    type:
      - 'null'
      - File
    doc: A TSV file where each line represents a sample.
    inputBinding:
      position: 101
      prefix: --sample-sheet
  - id: seed
    type:
      - 'null'
      - int
    doc: seed for random number generator (0)
    default: 0
    inputBinding:
      position: 101
      prefix: --seed
  - id: sequences_themselves
    type:
      - 'null'
      - boolean
    doc: <m1>, <m2>, <r> are sequences themselves, not files
    inputBinding:
      position: 101
      prefix: -c
  - id: skip_reads
    type:
      - 'null'
      - int
    doc: skip the first <int> reads/pairs in the input (none)
    inputBinding:
      position: 101
      prefix: --skip
  - id: tab_format_columns
    type:
      - 'null'
      - string
    doc: "columns in tabular format, comma separated \n                          default:
      readID,seqID,taxID,score,2ndBestScore,hitLength,queryLength,numMatches"
    inputBinding:
      position: 101
      prefix: --tab-fmt-cols
  - id: threads
    type:
      - 'null'
      - int
    doc: number of alignment threads to launch (1)
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
  - id: time
    type:
      - 'null'
      - boolean
    doc: print wall-clock time taken by search phases
    inputBinding:
      position: 101
      prefix: --time
  - id: trim3
    type:
      - 'null'
      - int
    doc: trim <int> bases from 3'/right end of reads (0)
    default: 0
    inputBinding:
      position: 101
      prefix: --trim3
  - id: trim5
    type:
      - 'null'
      - int
    doc: trim <int> bases from 5'/left end of reads (0)
    default: 0
    inputBinding:
      position: 101
      prefix: --trim5
  - id: unpaired_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: "Files with unpaired reads.\n             Could be gzip'ed (extension: .gz)
      or bzip2'ed (extension: .bz2)."
    inputBinding:
      position: 101
      prefix: -U
  - id: upto_reads
    type:
      - 'null'
      - int
    doc: stop after first <int> reads/pairs (no limit)
    inputBinding:
      position: 101
      prefix: --upto
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: 'File for classification output (default: stdout)'
    outputBinding:
      glob: $(inputs.output_file)
  - id: report_file
    type:
      - 'null'
      - File
    doc: 'File for tabular report output (default: centrifuge_report.tsv)'
    outputBinding:
      glob: $(inputs.report_file)
  - id: unaligned_reads_output
    type:
      - 'null'
      - File
    doc: write unpaired reads that didn't align to <path>
    outputBinding:
      glob: $(inputs.unaligned_reads_output)
  - id: aligned_reads_output
    type:
      - 'null'
      - File
    doc: write unpaired reads that aligned at least once to <path>
    outputBinding:
      glob: $(inputs.aligned_reads_output)
  - id: unconc_pairs_output
    type:
      - 'null'
      - File
    doc: write pairs that didn't align concordantly to <path>
    outputBinding:
      glob: $(inputs.unconc_pairs_output)
  - id: conc_pairs_output
    type:
      - 'null'
      - File
    doc: write pairs that aligned concordantly at least once to <path>
    outputBinding:
      glob: $(inputs.conc_pairs_output)
  - id: unaligned_reads_gz_output
    type:
      - 'null'
      - File
    doc: write unpaired reads that didn't align to <path> (gzipped)
    outputBinding:
      glob: $(inputs.unaligned_reads_gz_output)
  - id: aligned_reads_gz_output
    type:
      - 'null'
      - File
    doc: write unpaired reads that aligned at least once to <path> (gzipped)
    outputBinding:
      glob: $(inputs.aligned_reads_gz_output)
  - id: unconc_pairs_gz_output
    type:
      - 'null'
      - File
    doc: write pairs that didn't align concordantly to <path> (gzipped)
    outputBinding:
      glob: $(inputs.unconc_pairs_gz_output)
  - id: conc_pairs_gz_output
    type:
      - 'null'
      - File
    doc: write pairs that aligned concordantly at least once to <path> (gzipped)
    outputBinding:
      glob: $(inputs.conc_pairs_gz_output)
  - id: unaligned_reads_bz2_output
    type:
      - 'null'
      - File
    doc: write unpaired reads that didn't align to <path> (bzip2 compressed)
    outputBinding:
      glob: $(inputs.unaligned_reads_bz2_output)
  - id: aligned_reads_bz2_output
    type:
      - 'null'
      - File
    doc: write unpaired reads that aligned at least once to <path> (bzip2 
      compressed)
    outputBinding:
      glob: $(inputs.aligned_reads_bz2_output)
  - id: unconc_pairs_bz2_output
    type:
      - 'null'
      - File
    doc: write pairs that didn't align concordantly to <path> (bzip2 compressed)
    outputBinding:
      glob: $(inputs.unconc_pairs_bz2_output)
  - id: conc_pairs_bz2_output
    type:
      - 'null'
      - File
    doc: write pairs that aligned concordantly at least once to <path> (bzip2 
      compressed)
    outputBinding:
      glob: $(inputs.conc_pairs_bz2_output)
  - id: metrics_file
    type:
      - 'null'
      - File
    doc: send metrics to file at <path> (off)
    outputBinding:
      glob: $(inputs.metrics_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
