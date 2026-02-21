cwlVersion: v1.2
class: CommandLineTool
baseCommand: hamroaster
label: hamroaster
doc: "The provided text does not contain help information or a description of the
  tool; it contains error logs related to a container runtime failure (no space left
  on device).\n\nTool homepage: https://github.com/ewissel/hAMRoaster"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hamroaster:2.0--hdfd78af_0
stdout: hamroaster.out
