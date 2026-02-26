cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - transcov
  - pick-subset
label: transcov_pick-subset
doc: "Picks a subset of samples from a transcov index.\n\nTool homepage: https://github.com/hogfeldt/transcov"
inputs:
  - id: input_sample
    type: string
    doc: The input sample to pick from.
    inputBinding:
      position: 1
  - id: index_file
    type: File
    doc: The transcov index file.
    inputBinding:
      position: 2
  - id: ids_file
    type: File
    doc: A file containing the sample IDs to pick.
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/transcov:1.1.3--py_0
stdout: transcov_pick-subset.out
