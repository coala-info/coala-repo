cwlVersion: v1.2
class: CommandLineTool
baseCommand: neffy-cli_converter
label: neffy-cli_converter
doc: "Converting OCI blobs to SIF format\n\nTool homepage: https://maryam-haghani.github.io/NEFFy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/neffy-cli:0.1.1--h9948957_0
stdout: neffy-cli_converter.out
