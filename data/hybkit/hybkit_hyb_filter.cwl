cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybkit_hyb_filter
label: hybkit_hyb_filter
doc: "The provided text is an error log indicating a failure to build or run the container
  image and does not contain help information or argument definitions.\n\nTool homepage:
  https://github.com/RenneLab/hybkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybkit:0.3.6--pyhdfd78af_0
stdout: hybkit_hyb_filter.out
