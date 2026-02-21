cwlVersion: v1.2
class: CommandLineTool
baseCommand: predex
label: predex
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build/pull attempt.\n\nTool homepage: https://github.com/tomkuipers1402/predex"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/predex:0.9.3--pyh5e36f6f_0
stdout: predex.out
