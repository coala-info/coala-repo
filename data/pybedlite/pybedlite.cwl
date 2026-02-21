cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybedlite
label: pybedlite
doc: "A lightweight tool for BED file manipulation (Note: The provided text contains
  container build logs rather than tool help text; arguments could not be extracted).\n
  \nTool homepage: https://pypi.org/project/pybedlite/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybedlite:1.1.0--pyhdfd78af_1
stdout: pybedlite.out
