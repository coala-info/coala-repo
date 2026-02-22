cwlVersion: v1.2
class: CommandLineTool
baseCommand: bronko
label: bronko
doc: "The provided text does not contain help information or a description of the
  tool's functionality; it contains system error logs related to a container execution
  failure.\n\nTool homepage: https://github.com/treangenlab/bronko"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bronko:0.1.3--h4349ce8_0
stdout: bronko.out
