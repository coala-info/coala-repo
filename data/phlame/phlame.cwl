cwlVersion: v1.2
class: CommandLineTool
baseCommand: phlame
label: phlame
doc: "The provided text does not contain help information or a description of the
  tool; it contains container execution logs and a fatal error message regarding an
  OCI image fetch failure.\n\nTool homepage: https://github.com/quevan/phlame"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phlame:1.1.0--pyhdfd78af_0
stdout: phlame.out
