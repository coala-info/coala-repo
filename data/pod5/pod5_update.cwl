cwlVersion: v1.2
class: CommandLineTool
baseCommand: pod5_update
label: pod5_update
doc: "Update a pod5 files to the latest available version\n\nTool homepage: https://github.com/nanoporetech/pod5-file-format"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Input pod5 file(s) to update
    inputBinding:
      position: 1
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite destination files
    default: false
    inputBinding:
      position: 102
      prefix: --force-overwrite
  - id: output
    type: Directory
    doc: Output directory for updated pod5 files
    inputBinding:
      position: 102
      prefix: --output
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search for input files recursively matching `*.pod5`
    default: false
    inputBinding:
      position: 102
      prefix: --recursive
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pod5:0.3.33--pyhdfd78af_0
stdout: pod5_update.out
