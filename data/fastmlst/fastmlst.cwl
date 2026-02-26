cwlVersion: v1.2
class: CommandLineTool
baseCommand: fastmlst
label: fastmlst
doc: "fastMLST is a tool for rapid MLST typing of bacterial pathogens.\n\nTool homepage:
  https://github.com/EnzoAndree/FastMLST"
inputs:
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for downloading schemes.
    default: 20
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastmlst:0.0.19--pyhdfd78af_0
stdout: fastmlst.out
