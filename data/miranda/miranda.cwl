cwlVersion: v1.2
class: CommandLineTool
baseCommand: miranda
label: miranda
doc: "The provided text does not contain help information for the tool. It contains
  container runtime error messages regarding a lack of disk space while attempting
  to pull the miranda image.\n\nTool homepage: https://github.com/miranda-ng/miranda-ng"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/miranda:3.3a--h7b50bb2_9
stdout: miranda.out
