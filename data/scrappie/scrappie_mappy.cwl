cwlVersion: v1.2
class: CommandLineTool
baseCommand: mappy
label: scrappie_mappy
doc: "Scrappie squiggler\n\nTool homepage: https://github.com/nanoporetech/scrappie"
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
  - id: backprob
    type:
      - 'null'
      - float
    doc: Probability of backwards movement
    inputBinding:
      position: 103
      prefix: --backprob
  - id: localpen
    type:
      - 'null'
      - float
    doc: Penalty for local matching
    inputBinding:
      position: 103
      prefix: --localpen
  - id: minscore
    type:
      - 'null'
      - float
    doc: Minimum possible score for matching emission
    inputBinding:
      position: 103
      prefix: --minscore
  - id: model
    type:
      - 'null'
      - string
    doc: 'Squiggle model to use: "squiggle_r94", "squiggle_r10"'
    inputBinding:
      position: 103
      prefix: --model
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to append to name of read
    inputBinding:
      position: 103
      prefix: --prefix
  - id: rate
    type:
      - 'null'
      - float
    doc: Translocation rate of read relative to standard squiggle
    inputBinding:
      position: 103
      prefix: --rate
  - id: segmentation
    type:
      - 'null'
      - string
    doc: Chunk size and percentile for variance based segmentation
    inputBinding:
      position: 103
      prefix: --segmentation
  - id: skippen
    type:
      - 'null'
      - float
    doc: Penalty for skipping position
    inputBinding:
      position: 103
      prefix: --skippen
  - id: trim
    type:
      - 'null'
      - string
    doc: Number of samples to trim, as start:end
    inputBinding:
      position: 103
      prefix: --trim
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Write to file rather than stdout
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scrappie:1.4.2--py310pl5321h9a1f509_7
