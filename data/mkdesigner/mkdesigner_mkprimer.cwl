cwlVersion: v1.2
class: CommandLineTool
baseCommand: mkdesigner_mkprimer
label: mkdesigner_mkprimer
doc: "The provided text contains container runtime errors (Apptainer/Singularity)
  rather than the tool's help documentation. As a result, no arguments or functional
  descriptions could be extracted.\n\nTool homepage: https://github.com/KChigira/mkdesigner/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mkdesigner:0.5.2--pyhdfd78af_0
stdout: mkdesigner_mkprimer.out
