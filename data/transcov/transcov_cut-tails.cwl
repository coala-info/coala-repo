cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transcov
  - cut-tails
label: transcov_cut-tails
doc: "Cut tails of coverage profiles.\n\nTool homepage: https://github.com/hogfeldt/transcov"
inputs:
  - id: input_matrix
    type: File
    doc: Input coverage matrix file.
    inputBinding:
      position: 1
  - id: index_file
    type: File
    doc: Index file for the coverage matrix.
    inputBinding:
      position: 2
  - id: cut
    type:
      - 'null'
      - string
    doc: Cut range (e.g., '0.1-0.9').
    inputBinding:
      position: 103
      prefix: --cut
  - id: mode
    type:
      - 'null'
      - string
    doc: "Mode for cutting tails: 'both', 'left', or 'right'."
    inputBinding:
      position: 103
      prefix: --mode
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output file path.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
