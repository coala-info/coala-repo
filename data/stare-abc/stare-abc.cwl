cwlVersion: v1.2
class: CommandLineTool
baseCommand: stare-abc
label: stare-abc
doc: "Spatio-Temporal Analysis of REgulatory elements - Activity, Binding, and Chromatin
  (Note: The provided text contains container build logs and error messages rather
  than tool help text; no arguments could be extracted from the input).\n\nTool homepage:
  https://github.com/SchulzLab/STARE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stare-abc:1.0.5--h503566f_0
stdout: stare-abc.out
