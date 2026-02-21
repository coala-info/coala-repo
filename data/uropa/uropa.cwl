cwlVersion: v1.2
class: CommandLineTool
baseCommand: uropa
label: uropa
doc: "Universal ROBUST Peak Annotator (UROPA) is a tool for annotating genomic features
  (peaks) with proximity to genes or other genomic elements.\n\nTool homepage: https://github.molgen.mpg.de/loosolab/UROPA"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/uropa:4.0.3--pyhdfd78af_0
stdout: uropa.out
