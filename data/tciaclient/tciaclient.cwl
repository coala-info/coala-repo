cwlVersion: v1.2
class: CommandLineTool
baseCommand: tciaclient
label: tciaclient
doc: "The provided text does not contain help information or usage instructions; it
  is a log of a failed container build process. No arguments or descriptions could
  be extracted from the input.\n\nTool homepage: https://github.com/moritzschwyzer/tciaclient/tree/master/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tciaclient:0.0.3--pyhdfd78af_0
stdout: tciaclient.out
