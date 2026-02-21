cwlVersion: v1.2
class: CommandLineTool
baseCommand: nail
label: nail
doc: "The provided text contains system error logs related to a container runtime
  failure (no space left on device) rather than the help documentation for the 'nail'
  tool. As a result, no arguments or tool descriptions could be extracted.\n\nTool
  homepage: https://github.com/TravisWheelerLab/nail"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nail:0.4.0--h4349ce8_1
stdout: nail.out
