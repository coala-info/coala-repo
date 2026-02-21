cwlVersion: v1.2
class: CommandLineTool
baseCommand: reditools
label: reditools3_reditools
doc: "REDItools3 is a suite of python scripts for the analysis of RNA editing at genomic
  scale.\n\nTool homepage: https://github.com/BioinfoUNIBA/REDItools3"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/reditools3:3.5--pyhdfd78af_0
stdout: reditools3_reditools.out
