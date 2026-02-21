cwlVersion: v1.2
class: CommandLineTool
baseCommand: repeatscout_filter-stage-2.prl
label: repeatscout_filter-stage-2.prl
doc: "A filtering script for RepeatScout. Note: The provided help text contains container
  runtime error messages and does not list specific command-line arguments.\n\nTool
  homepage: https://github.com/Dfam-consortium/RepeatScout"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
stdout: repeatscout_filter-stage-2.prl.out
