cwlVersion: v1.2
class: CommandLineTool
baseCommand: argutils
label: argutils
doc: "The provided text does not contain help information for the tool; it consists
  of container runtime logs indicating that the executable 'argutils' was not found
  in the system PATH.\n\nTool homepage: https://github.com/eclarke/argutils"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/argutils:0.3.2--py36_1
stdout: argutils.out
