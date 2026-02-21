cwlVersion: v1.2
class: CommandLineTool
baseCommand: rpfa_straindesign
label: rpfa_straindesign
doc: "Strain design using Relative Protein Flux Analysis (RPFA). Note: The provided
  help text contains system logs and build errors rather than command usage; therefore,
  no arguments could be extracted.\n\nTool homepage: https://github.com/brsynth/rpFbaAnalysis"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rpfa:1.0.1--pyh5e36f6f_0
stdout: rpfa_straindesign.out
