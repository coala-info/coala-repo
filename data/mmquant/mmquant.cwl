cwlVersion: v1.2
class: CommandLineTool
baseCommand: mmquant
label: mmquant
doc: "A tool for multi-mapping read quantification. (Note: The provided text contains
  container runtime error messages and does not include the actual help documentation
  or usage instructions for the tool.)\n\nTool homepage: https://bitbucket.org/mzytnicki/multi-mapping-counter/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mmquant:1.0.9--h077b44d_1
stdout: mmquant.out
