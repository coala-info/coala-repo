cwlVersion: v1.2
class: CommandLineTool
baseCommand: sambamba
label: sambamba
doc: "The provided text does not contain help information for the tool. It consists
  of container environment logs and a fatal error message regarding the retrieval
  of the sambamba OCI image.\n\nTool homepage: https://github.com/biod/sambamba"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sambamba:1.0.1--he614052_4
stdout: sambamba.out
