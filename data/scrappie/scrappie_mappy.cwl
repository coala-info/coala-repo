cwlVersion: v1.2
class: CommandLineTool
baseCommand: [scrappie, mappy]
label: scrappie_mappy
doc: "Scrappie squiggler: map signal to approximate squiggle\n\nTool homepage: https://github.com/nanoporetech/scrappie"
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
  - id: model
    type: ['null', string]
    doc: "Squiggle model to use: \"squiggle_r94\", \"squiggle_r10\""
    inputBinding:
      prefix: --model
  - id: backprob
    type: ['null', double]
    doc: "Probability of backwards movement"
    inputBinding:
      prefix: --backprob
  - id: skippen
    type: ['null', double]
    doc: "Penalty for skipping position"
    inputBinding:
      prefix: --skippen
  - id: localpen
    type: ['null', double]
    doc: "Penalty for local matching"
    inputBinding:
      prefix: --localpen
  - id: minscore
    type: ['null', double]
    doc: "Minimum possible score for matching emission"
    inputBinding:
      prefix: --minscore
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
  - id: rate
    type: ['null', double]
    doc: "Translocation rate of read relative to standard squiggle"
    inputBinding:
      prefix: --rate
  - id: segmentation
    type: ['null', string]
    doc: "Chunk size and percentile for variance based segmentation (chunk:percentile)"
    inputBinding:
      prefix: --segmentation
  - id: trim
    type: ['null', string]
    doc: "Number of samples to trim, as start:end"
    inputBinding:
      prefix: --trim
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
stdout: scrappie_mappy.out
