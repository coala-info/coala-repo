cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scrappie, seqmappy]
label: scrappie_seqmappy
doc: "Scrappie seqmappy (local-global): map signal to sequence via basecall posteriors\n\nTool homepage: https://github.com/nanoporetech/scrappie"
inputs:
  - id: fasta_file
    type: File
    doc: "Input fasta file"
    inputBinding:
      position: 200
  - id: fast5_file
    type: File
    doc: "Input fast5 file"
    inputBinding:
      position: 201
  - id: localpen
    type: ['null', double]
    doc: "Penalty for local matching"
    inputBinding:
      prefix: --localpen
  - id: min_prob
    type: ['null', double]
    doc: "Minimum bound on probability of match"
    inputBinding:
      prefix: --min_prob
  - id: output
    type: ['null', string]
    doc: "Write to file rather than stdout"
    inputBinding:
      prefix: --output
  - id: prefix
    type: ['null', string]
    doc: "Prefix to append to name of read"
    inputBinding:
      prefix: --prefix
  - id: segmentation
    type: ['null', string]
    doc: "Chunk size and percentile for variance based segmentation (chunk:percentile)"
    inputBinding:
      prefix: --segmentation
  - id: skip
    type: ['null', double]
    doc: "Penalty for skipping a base"
    inputBinding:
      prefix: --skip
  - id: temperature1
    type: ['null', double]
    doc: "Temperature for softmax weights"
    inputBinding:
      prefix: --temperature1
  - id: temperature2
    type: ['null', double]
    doc: "Temperature for softmax bias"
    inputBinding:
      prefix: --temperature2
  - id: trim
    type: ['null', string]
    doc: "Number of samples to trim, as start:end"
    inputBinding:
      prefix: --trim
  - id: stay
    type: ['null', double]
    doc: "Penalty for staying"
    inputBinding:
      prefix: --stay
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (used when --output is not set)
  - id: output_file
    type: ['null', File]
    doc: Output file written with --output
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
stdout: scrappie_seqmappy.out
