cwlVersion: v1.2
class: CommandLineTool
baseCommand: wb_command
label: connectome-workbench_wb_command
doc: "The provided text does not contain help information; it contains error messages
  related to a system failure (no space left on device) while attempting to run a
  Singularity container for the connectome-workbench tool.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
stdout: connectome-workbench_wb_command.out
