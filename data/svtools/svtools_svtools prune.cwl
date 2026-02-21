cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - svtools
  - prune
label: svtools_svtools prune
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container build failure.\n\nTool homepage:
  https://github.com/hall-lab/svtools"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/svtools:0.5.1--py_0
stdout: svtools_svtools prune.out
