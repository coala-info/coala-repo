cwlVersion: v1.2
class: CommandLineTool
baseCommand: count
label: ntstat_count
doc: "Count k-mers from sequencing data using a k-mer spectrum file.\n\nTool homepage:
  https://github.com/bcgsc/ntStat"
inputs:
  - id: reads
    type:
      type: array
      items: File
    doc: path to sequencing data file(s)
    inputBinding:
      position: 1
  - id: kmer_length
    type:
      - 'null'
      - int
    doc: k-mer length
    inputBinding:
      position: 102
      prefix: -k
  - id: kmer_spectrum_file
    type: File
    doc: path to k-mer spectrum file (from ntCard)
    inputBinding:
      position: 102
      prefix: -f
  - id: optimize_long_read
    type:
      - 'null'
      - boolean
    doc: optimize for long read data
    inputBinding:
      position: 102
      prefix: --long
  - id: output_cbf_size
    type:
      - 'null'
      - int
    doc: output CBF size (bytes)
    inputBinding:
      position: 102
      prefix: -b
  - id: spaced_seeds_file
    type:
      - 'null'
      - File
    doc: path to spaced seeds file (one per line, if -k not specified)
    inputBinding:
      position: 102
      prefix: -s
  - id: target_error_rate
    type:
      - 'null'
      - float
    doc: target output count error rate
    default: 0.001
    inputBinding:
      position: 102
      prefix: -e
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    default: 1
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: output_file
    type: File
    doc: path to store output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ntstat:1.0.1--py311he264feb_2
