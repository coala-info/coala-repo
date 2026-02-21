cwlVersion: v1.2
class: CommandLineTool
baseCommand: seqspec
label: seqspec
doc: "The provided text does not contain help information for the 'seqspec' tool.
  It is a log of a failed container build process due to insufficient disk space ('no
  space left on device').\n\nTool homepage: https://github.com/sbooeshaghi/seqspec"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqspec:0.4.0--pyhdfd78af_0
stdout: seqspec.out
