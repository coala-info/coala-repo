cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - scenicplus
  - grn_inference
label: scenicplus_grn_inference
doc: "Infer Enhancer driven Gene Regulatory Networks.\n\nTool homepage: https://github.com/aertslab/scenicplus"
inputs:
  - id: subcommand
    type: string
    doc: Subcommand for GRN inference
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scenicplus:1.0a2--pyhdfd78af_0
stdout: scenicplus_grn_inference.out
