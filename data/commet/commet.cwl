cwlVersion: v1.2
class: CommandLineTool
baseCommand: commet
label: commet
doc: "The provided text does not contain help information or a description of the
  tool; it is an error log indicating a failure to pull or run a container due to
  lack of disk space.\n\nTool homepage: https://colibread.inria.fr/software/commet/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/commet:24.7.14--r44h077b44d_13
stdout: commet.out
