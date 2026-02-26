cwlVersion: v1.2
class: CommandLineTool
baseCommand: pod5_recover
label: pod5_recover
doc: "Attempt to recover pod5 files. Recovered files are written to sibling files
  with the '_recovered.pod5` suffix\n\nTool homepage: https://github.com/nanoporetech/pod5-file-format"
inputs:
  - id: inputs
    type:
      type: array
      items: File
    doc: Input pod5 file(s) to update
    inputBinding:
      position: 1
  - id: cleanup
    type:
      - 'null'
      - boolean
    doc: Delete successfully recovered input files and files with no data to 
      recover.
    inputBinding:
      position: 102
      prefix: --cleanup
  - id: force_overwrite
    type:
      - 'null'
      - boolean
    doc: Overwrite destination files
    inputBinding:
      position: 102
      prefix: --force-overwrite
  - id: recursive
    type:
      - 'null'
      - boolean
    doc: Search for input files recursively matching `*.pod5`
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
stdout: pod5_recover.out
