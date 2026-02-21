cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqmagick
label: seqmagick
doc: "The provided text is an error log and does not contain help information for
  the tool.\n\nTool homepage: http://github.com/fhcrc/seqmagick"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqmagick:0.8.6--pyhdfd78af_0
stdout: seqmagick.out
