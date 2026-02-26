cwlVersion: v1.2
class: CommandLineTool
baseCommand: sadie
label: sadie-antibody_sadie
doc: "SADIE Antibody Analysis\n\nTool homepage: https://sadie.jordanrwillis.com"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Vebosity level, ex. -vvvvv for debug level logging
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sadie-antibody:2.0.0--pyhdfd78af_0
stdout: sadie-antibody_sadie.out
