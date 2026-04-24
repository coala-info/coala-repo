cwlVersion: v1.2
class: CommandLineTool
baseCommand: bio
label: bio_meta
doc: "A tool for biological metadata operations.\n\nTool homepage: https://github.com/ialbert/bio"
inputs:
  - id: terms
    type:
      - 'null'
      - type: array
        items: string
    doc: Terms to search for
    inputBinding:
      position: 1
  - id: header
    type:
      - 'null'
      - boolean
    doc: print header
    inputBinding:
      position: 102
      prefix: --header
  - id: limit
    type:
      - 'null'
      - string
    doc: download limit
    inputBinding:
      position: 102
      prefix: --limit
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bio:1.8.1--pyhdfd78af_0
stdout: bio_meta.out
