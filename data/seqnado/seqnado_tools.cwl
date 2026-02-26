cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqnado_tools
label: seqnado_tools
doc: "Available Tools in SeqNado Pipeline\n\nTool homepage: https://alsmith151.github.io/SeqNado/"
inputs:
  - id: tool
    type: string
    doc: The specific tool to get help for.
    inputBinding:
      position: 1
  - id: options
    type:
      - 'null'
      - boolean
    doc: Show tool options from the container.
    inputBinding:
      position: 102
      prefix: --options
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqnado:1.0.4--pyhdfd78af_0
stdout: seqnado_tools.out
