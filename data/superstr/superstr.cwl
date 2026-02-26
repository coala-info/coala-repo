cwlVersion: v1.2
class: CommandLineTool
baseCommand: superstr
label: superstr
doc: "Rapid STR characterisation in NGS data.\n\nTool homepage: https://github.com/bahlolab/superSTR"
inputs:
  - id: input_files
    type:
      - 'null'
      - type: array
        items: File
    doc: input files (or names of pipes in stream mode)
    inputBinding:
      position: 1
  - id: mode
    type:
      - 'null'
      - string
    doc: type of input data
    inputBinding:
      position: 102
      prefix: --mode
  - id: retain
    type:
      - 'null'
      - int
    doc: write retained reads
    inputBinding:
      position: 102
      prefix: -r
  - id: stream
    type:
      - 'null'
      - boolean
    doc: run on named streams, not files (see manual for instructions)
    inputBinding:
      position: 102
      prefix: --stream
  - id: threshold
    type:
      - 'null'
      - float
    doc: compression threshold for processing strings
    inputBinding:
      position: 102
      prefix: --threshold
outputs:
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/superstr:1.0.1--h86fab0c_5
