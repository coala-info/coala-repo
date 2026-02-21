cwlVersion: v1.2
class: CommandLineTool
baseCommand: snk-cli
label: snk-cli
doc: "The provided text does not contain help information or usage instructions; it
  appears to be a log of a failed container build or execution process.\n\nTool homepage:
  https://github.com/wytamma/snk-cli"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snk-cli:0.7.2--pyhdfd78af_0
stdout: snk-cli.out
