cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - hybkit
  - hyb_analyze
label: hybkit_hyb_analyze
doc: "A tool for analyzing hybrid sequences (Note: The provided help text contained
  only system error messages and no usage information).\n\nTool homepage: https://github.com/RenneLab/hybkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybkit:0.3.6--pyhdfd78af_0
stdout: hybkit_hyb_analyze.out
