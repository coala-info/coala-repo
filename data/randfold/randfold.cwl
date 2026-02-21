cwlVersion: v1.2
class: CommandLineTool
baseCommand: randfold
label: randfold
doc: "The provided text does not contain help information for the tool. It contains
  error messages related to a container build failure.\n\nTool homepage: https://github.com/erbon7/randfold"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/randfold:2.0.1--h7b50bb2_9
stdout: randfold.out
