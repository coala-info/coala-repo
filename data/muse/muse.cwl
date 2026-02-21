cwlVersion: v1.2
class: CommandLineTool
baseCommand: muse
label: muse
doc: "The provided text does not contain help information for the tool 'muse'. It
  contains container runtime error messages indicating a failure to build the SIF
  image due to lack of disk space.\n\nTool homepage: http://bioinformatics.mdanderson.org/main/MuSE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/muse:2.1.2--h3b3e331_3
stdout: muse.out
