cwlVersion: v1.2
class: CommandLineTool
baseCommand: wade
label: wade_WamR-Pneumo
doc: "WGS Analysis and Detection Engine (WADE) for Streptococcus pneumoniae. Note:
  The provided text contains container build logs and error messages rather than command-line
  help documentation, so no arguments could be extracted.\n\nTool homepage: https://github.com/phac-nml/wade"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/wade:1.2.0--r44hdfd78af_0
stdout: wade_WamR-Pneumo.out
