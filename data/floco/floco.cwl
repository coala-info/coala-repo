cwlVersion: v1.2
class: CommandLineTool
baseCommand: floco
label: floco
doc: "The provided text contains system error logs related to container execution
  rather than tool help documentation. No arguments or descriptions could be extracted
  from the input.\n\nTool homepage: https://github.com/hugocarmaga/floco"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/floco:1.0.1--pyhdfd78af_0
stdout: floco.out
