cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqerakit
label: seqerakit
doc: "The provided text does not contain help information for seqerakit; it is an
  error log from a failed container build process (no space left on device).\n\nTool
  homepage: https://github.com/seqeralabs/seqera-kit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqerakit:0.5.6--pyhdfd78af_0
stdout: seqerakit.out
