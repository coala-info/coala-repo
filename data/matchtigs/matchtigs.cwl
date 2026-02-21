cwlVersion: v1.2
class: CommandLineTool
baseCommand: matchtigs
label: matchtigs
doc: "The provided text does not contain help information or a description of the
  tool; it contains container runtime error messages regarding disk space.\n\nTool
  homepage: https://github.com/algbio/matchtigs.git"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/matchtigs:2.1.9--hc1c3326_0
stdout: matchtigs.out
