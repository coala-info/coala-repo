cwlVersion: v1.2
class: CommandLineTool
baseCommand: mauve
label: mauve
doc: "Mauve is a system for constructing multiple genome alignments in the presence
  of large-scale evolutionary events such as rearrangement and inversion.\n\nTool
  homepage: http://darlinglab.org/mauve/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mauve:2.4.0.snapshot_2015_02_13--h2688d6d_0
stdout: mauve.out
