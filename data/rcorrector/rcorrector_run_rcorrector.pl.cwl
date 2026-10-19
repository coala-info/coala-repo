cwlVersion: v1.2
class: CommandLineTool
baseCommand: run_rcorrector.pl
label: rcorrector_run_rcorrector.pl
doc: "Rcorrector: error correction for Illumina RNA-seq reads.\n\nTool homepage: https://github.com/mourisl/Rcorrector/"
inputs:
  - id: single_end_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: "comma separated files for single-end data sets"
    inputBinding:
      prefix: "-s"
      itemSeparator: ","
  - id: read1
    type:
      - 'null'
      - type: array
        items: File
    doc: "comma separated files for the first mate in the paired-end data sets"
    inputBinding:
      prefix: "-1"
      itemSeparator: ","
  - id: read2
    type:
      - 'null'
      - type: array
        items: File
    doc: "comma separated files for the second mate in the paired-end data sets"
    inputBinding:
      prefix: "-2"
      itemSeparator: ","
  - id: interleaved_reads
    type:
      - 'null'
      - type: array
        items: File
    doc: "comma separated files for interleaved paired-end data sets"
    inputBinding:
      prefix: "-i"
      itemSeparator: ","
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: "kmer length (<=32, default: 23)"
    inputBinding:
      prefix: "-k"
  - id: output_directory
    type:
      - 'null'
      - string
    doc: "output file directory (default: ./)"
    inputBinding:
      prefix: "-od"
  - id: threads
    type:
      - 'null'
      - int
    doc: "number of threads (default: 1)"
    inputBinding:
      prefix: "-t"
  - id: max_corrections_per_window
    type:
      - 'null'
      - int
    doc: "the maximum number of correction within k-bp window (default: 4)"
    inputBinding:
      prefix: "-maxcorK"
  - id: weak_kmer_proportion
    type:
      - 'null'
      - float
    doc: "the proportion of kmers that are used to estimate weak kmer count threshold, lower for more divergent genome (default: 0.95)"
    inputBinding:
      prefix: "-wk"
  - id: expected_kmers
    type:
      - 'null'
      - string
    doc: "expected number of kmers: does not affect the correctness of the program but affects the memory usage (default: 100000000)"
    inputBinding:
      prefix: "-ek"
  - id: stdout_reads
    type:
      - 'null'
      - boolean
    doc: "output the corrected reads to stdout (default: not used)"
    inputBinding:
      prefix: "-stdout"
  - id: temp_directory
    type:
      - 'null'
      - string
    doc: "directory for temporary files (default: ./)"
    inputBinding:
      prefix: "-tmpd"
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: "output some correction information to stdout (default: not used)"
    inputBinding:
      prefix: "-verbose"
  - id: stage
    type:
      - 'null'
      - int
    doc: "start from which stage (default: 0): 0 storing kmers in bloom filter; 1 count kmers showed up in bloom filter; 2 dumping kmer counts into a jf_dump file; 3 error correction"
    inputBinding:
      prefix: "-stage"
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the corrected reads when stdout_reads is set)
  - id: corrected_reads
    type:
      type: array
      items: File
    doc: Corrected read files (*.cor.fq / *.cor.fa)
    outputBinding:
      glob: "$((inputs.output_directory ? inputs.output_directory + '/' : '') + '*.cor.f*')"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rcorrector:1.0.7--pl5321h5ca1c30_2
stdout: rcorrector_stdout.txt
