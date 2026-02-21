cwlVersion: v1.2
class: CommandLineTool
baseCommand: unassigner
label: unassigner
doc: "The provided text does not contain help information or a description of the
  tool. It appears to be a log of a failed container build process.\n\nTool homepage:
  https://github.com/PennChopMicrobiomeProgram/unassigner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unassigner:1.1.0--pyh7e72e81_0
stdout: unassigner.out
