cwlVersion: v1.2
class: CommandLineTool
baseCommand: repeatscout_filter-stage-1.prl
label: repeatscout_filter-stage-1.prl
doc: "A script for the first stage of filtering RepeatScout results. (Note: The provided
  help text contains only container runtime error messages and no usage information.)\n
  \nTool homepage: https://github.com/Dfam-consortium/RepeatScout"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/repeatscout:1.0.7--h7b50bb2_1
stdout: repeatscout_filter-stage-1.prl.out
