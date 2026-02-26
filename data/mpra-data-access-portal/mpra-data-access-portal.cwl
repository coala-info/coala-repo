cwlVersion: v1.2
class: CommandLineTool
baseCommand: mpra-data-access-portal
label: mpra-data-access-portal
doc: "Shiny app is started when called without options.\n\nTool homepage: https://mpra.gs.washington.edu/satMutMPRA"
inputs:
  - id: self_test
    type:
      - 'null'
      - boolean
    doc: Run self-check and tests
    inputBinding:
      position: 101
      prefix: --self-test
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mpra-data-access-portal:0.1.11--hdfd78af_0
stdout: mpra-data-access-portal.out
