cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio
label: bio_uniq
doc: "\nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: fnames
    type:
      - 'null'
      - type: array
        items: File
    doc: file names
    inputBinding:
      position: 1
  - id: count
    type:
      - 'null'
      - boolean
    doc: produce counts
    inputBinding:
      position: 102
      prefix: --count
  - id: field
    type:
      - 'null'
      - int
    doc: field index
    default: 1
    inputBinding:
      position: 102
      prefix: --field
  - id: tab
    type:
      - 'null'
      - boolean
    doc: tab delimited (default is csv)
    inputBinding:
      position: 102
      prefix: --tab
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
stdout: bio_uniq.out
