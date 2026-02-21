cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - unassigner
  - unassign
label: unassigner_unassign
doc: "The provided text does not contain help information or usage instructions for
  the tool; it is a log of a failed container build process (Singularity/Apptainer).\n
  \nTool homepage: https://github.com/PennChopMicrobiomeProgram/unassigner"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/unassigner:1.1.0--pyh7e72e81_0
stdout: unassigner_unassign.out
