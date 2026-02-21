cwlVersion: v1.2
class: CommandLineTool
baseCommand: amas
label: amas
doc: "The provided text does not contain help information for the tool. It appears
  to be a container execution log ending in a fatal error indicating that the 'amas'
  executable was not found in the system PATH.\n\nTool homepage: https://github.com/marekborowiec/AMAS"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/amas:1.0--pyh864c0ab_0
stdout: amas.out
