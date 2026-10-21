cwlVersion: v1.2
class: CommandLineTool
baseCommand: [tin.py]
label: rseqc_tin.py
doc: "Calculate the transcript integrity number (TIN) for each transcript (or gene) in a BED file. TIN ranges from 0 (the worst) to 100 (the best); the median TIN across transcripts measures RNA integrity of the sample.\n\nTool homepage: https://rseqc.sourceforge.net"
inputs:
  - id: input_files
    type:
      - type: array
        items: File
    secondaryFiles:
      - pattern: .bai
        required: true
    doc: "Input BAM file(s). \"-i\" takes these input: 1) a single BAM file. 2) \",\" separated BAM files (no spaces allowed). 3) directory containing one or more bam files. 4) plain text file containing the path of one or more bam files (Each row is a BAM file path). All BAM files should be sorted and indexed using samtools."
    inputBinding:
      position: 1
      prefix: --input
      itemSeparator: ','
  - id: refgene
    type: File
    doc: "Reference gene model in BED format. Must be strandard 12-column BED file."
    inputBinding:
      position: 1
      prefix: --refgene
  - id: min_cov
    type:
      - 'null'
      - int
    doc: "Minimum number of read mapped to a transcript. default=10"
    inputBinding:
      position: 1
      prefix: --minCov
  - id: sample_size
    type:
      - 'null'
      - int
    doc: "Number of equal-spaced nucleotide positions picked from mRNA. Note: if this number is larger than the length of mRNA (L), it will be halved until it's smaller than L. default=100"
    inputBinding:
      position: 1
      prefix: --sample-size
  - id: subtract_background
    type:
      - 'null'
      - boolean
    doc: "Subtract background noise (estimated from intronic reads). Only use this option if there are substantial intronic reads."
    inputBinding:
      position: 1
      prefix: --subtract-background
outputs:
  - id: tin_xls
    type: File[]
    doc: "TIN score of each transcript, one file per input BAM."
    outputBinding:
      glob: "*.tin.xls"
  - id: summary
    type: File[]
    doc: "TIN summary (mean, median, stdev), one file per input BAM."
    outputBinding:
      glob: "*.summary.txt"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rseqc:5.0.4--pyhdfd78af_1
s:url: https://rseqc.sourceforge.net
$namespaces:
  s: https://schema.org/
