cwlVersion: v1.2
class: CommandLineTool
baseCommand: neffy-cli
label: neffy-cli
doc: "The provided text does not contain help information for neffy-cli; it is an
  error message regarding a container build failure due to insufficient disk space.\n
  \nTool homepage: https://maryam-haghani.github.io/NEFFy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neffy-cli:0.1.1--h9948957_0
stdout: neffy-cli.out
