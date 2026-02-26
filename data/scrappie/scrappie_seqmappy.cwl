cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqmappy
label: scrappie_seqmappy
doc: "Scrappie seqmappy (local-global)\n\nTool homepage: https://github.com/nanoporetech/scrappie"
inputs:
  - id: fasta_file
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: fast5_file
    type: File
    doc: Input FAST5 file
    inputBinding:
      position: 2
  - id: licence
    type:
      - 'null'
      - boolean
    doc: Print licensing information
    inputBinding:
      position: 103
      prefix: --licence
  - id: license
    type:
      - 'null'
      - boolean
    doc: Print licensing information
    inputBinding:
      position: 103
      prefix: --license
  - id: localpen
    type:
      - 'null'
      - float
    doc: Penalty for local matching
    inputBinding:
      position: 103
      prefix: --localpen
  - id: min_prob
    type:
      - 'null'
      - float
    doc: Minimum bound on probability of match
    inputBinding:
      position: 103
      prefix: --min_prob
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to append to name of read
    inputBinding:
      position: 103
      prefix: --prefix
  - id: segmentation
    type:
      - 'null'
      - string
    doc: Chunk size and percentile for variance based segmentation
    inputBinding:
      position: 103
      prefix: --segmentation
  - id: skip
    type:
      - 'null'
      - float
    doc: Penalty for skipping a base
    inputBinding:
      position: 103
      prefix: --skip
  - id: stay
    type:
      - 'null'
      - float
    doc: Penalty for staying
    inputBinding:
      position: 103
      prefix: --stay
  - id: temperature1
    type:
      - 'null'
      - float
    doc: Temperature for softmax weights
    inputBinding:
      position: 103
      prefix: --temperature1
  - id: temperature2
    type:
      - 'null'
      - float
    doc: Temperature for softmax bias
    inputBinding:
      position: 103
      prefix: --temperature2
  - id: trim
    type:
      - 'null'
      - string
    doc: Number of samples to trim, as start:end
    inputBinding:
      position: 103
      prefix: --trim
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Write to file rather than stdout
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
