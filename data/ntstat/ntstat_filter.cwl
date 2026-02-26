cwlVersion: v1.2
class: CommandLineTool
baseCommand: filter
label: ntstat_filter
doc: "Filters k-mer spectra based on various criteria.\n\nTool homepage: https://github.com/bcgsc/ntStat"
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
  - id: max_count_threshold
    type:
      - 'null'
      - int
    doc: maximum count threshold (<=255)
    default: 255
    inputBinding:
      position: 102
      prefix: -cmax
  - id: min_count_threshold
    type:
      - 'null'
      - int
    doc: minimum count threshold (>=1, or 0 for first minimum)
    default: 1
    inputBinding:
      position: 102
      prefix: -cmin
  - id: optimize_long_reads
    type:
      - 'null'
      - boolean
    doc: optimize for long read data
    inputBinding:
      position: 102
      prefix: --long
  - id: output_bf_cbf_size
    type:
      - 'null'
      - int
    doc: output BF/CBF size (bytes)
    inputBinding:
      position: 102
      prefix: -b
  - id: output_counts
    type:
      - 'null'
      - boolean
    doc: output counts (requires ~8x RAM for CBF)
    inputBinding:
      position: 102
      prefix: --counts
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
    doc: target output error rate
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
