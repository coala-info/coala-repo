cwlVersion: v1.2
class: CommandLineTool
baseCommand: centrifuge-RemoveN.pl
label: centrifuge-core_centrifuge-RemoveN.pl
doc: "A script within the centrifuge-core package, likely used for removing 'N' characters
  from sequence files. (Note: The provided help text contains only system error messages
  regarding a container build failure and does not list specific arguments.)\n\nTool
  homepage: https://github.com/infphilo/centrifuge"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/centrifuge-core:1.0.4.2--h5ca1c30_2
stdout: centrifuge-core_centrifuge-RemoveN.pl.out
