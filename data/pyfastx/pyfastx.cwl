cwlVersion: v1.2
class: CommandLineTool
baseCommand: pyfastx
label: pyfastx
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a container build failure.\n\nTool homepage: https://github.com/lmdu/pyfastx"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyfastx:2.3.0--py312h4711d71_1
stdout: pyfastx.out
