cwlVersion: v1.2
class: CommandLineTool
baseCommand: tantan
label: tantan
doc: "The provided text does not contain help information for the tool 'tantan'. It
  appears to be a series of system logs and a fatal error message related to fetching
  a container image.\n\nTool homepage: http://cbrc3.cbrc.jp/~martin/tantan/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tantan:51--h5ca1c30_1
stdout: tantan.out
