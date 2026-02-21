cwlVersion: v1.2
class: CommandLineTool
baseCommand: unassigner_trimragged
label: unassigner_trimragged
doc: "The provided text does not contain help information; it is a container execution
  error log.\n\nTool homepage: https://github.com/PennChopMicrobiomeProgram/unassigner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unassigner:1.1.0--pyh7e72e81_0
stdout: unassigner_trimragged.out
