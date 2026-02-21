cwlVersion: v1.2
class: CommandLineTool
baseCommand: piranha
label: piranha
doc: "The provided text does not contain help information or usage instructions. It
  appears to be a log of a failed execution attempt where the executable was not found.\n
  \nTool homepage: https://github.com/uber/piranha"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/piranha:1.2.1--h160c58d_6
stdout: piranha.out
