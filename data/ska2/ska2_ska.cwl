cwlVersion: v1.2
class: CommandLineTool
baseCommand: ska
label: ska2_ska
doc: "Split k-mer analysis\n\nTool homepage: https://github.com/bacpop/ska.rust"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Show progress messages
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ska2:0.5.1--h4349ce8_0
stdout: ska2_ska.out
