cwlVersion: v1.2
class: CommandLineTool
baseCommand: scaden_merge
label: scaden_merge
doc: "Merge simulated datasets into on training dataset\n\nTool homepage: https://github.com/KevinMenden/scaden"
inputs:
  - id: data_dir
    type:
      - 'null'
      - Directory
    doc: Directory containing simulated datasets (in .h5ad format)
    inputBinding:
      position: 101
      prefix: --data
  - id: filenames
    type:
      - 'null'
      - type: array
        items: string
    doc: Comma-separated list of filenames to merge
    inputBinding:
      position: 101
      prefix: --files
  - id: output_prefix
    type:
      - 'null'
      - string
    doc: Prefix of output file
    default: data
    inputBinding:
      position: 101
      prefix: --prefix
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
stdout: scaden_merge.out
