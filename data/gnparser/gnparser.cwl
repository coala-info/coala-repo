cwlVersion: v1.2
class: CommandLineTool
baseCommand: gnparser
label: gnparser
doc: "The provided text does not contain a description of the tool or its usage; it
  appears to be an error log from a container runtime environment.\n\nTool homepage:
  https://parser.globalnames.org/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gnparser:1.14.2--he881be0_0
stdout: gnparser.out
