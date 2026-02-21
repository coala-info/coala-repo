cwlVersion: v1.2
class: CommandLineTool
baseCommand: feelnc_FEELnc_pipeline.sh
label: feelnc_FEELnc_pipeline.sh
doc: "FEELnc pipeline for long non-coding RNA annotation. (Note: The provided input
  text contains container runtime error messages rather than tool help documentation,
  so no arguments could be extracted.)\n\nTool homepage: https://github.com/tderrien/FEELnc"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/feelnc:0.2--pl526_0
stdout: feelnc_FEELnc_pipeline.sh.out
