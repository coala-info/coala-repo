cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rpfbagr
  - straindesign
label: rpfbagr_straindesign
doc: "A tool for strain design (Note: The provided text contains container execution
  errors rather than command-line help documentation, so no arguments could be extracted).\n
  \nTool homepage: https://github.com/brsynth/rpfbagr"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rpfbagr:2.2.2--pyh5e36f6f_0
stdout: rpfbagr_straindesign.out
