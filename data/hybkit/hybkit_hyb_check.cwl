cwlVersion: v1.2
class: CommandLineTool
baseCommand: hybkit_hyb_check
label: hybkit_hyb_check
doc: "The provided text does not contain help information or usage instructions for
  the tool. It contains container runtime error messages indicating a failure to build
  the SIF image due to insufficient disk space.\n\nTool homepage: https://github.com/RenneLab/hybkit"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/hybkit:0.3.6--pyhdfd78af_0
stdout: hybkit_hyb_check.out
