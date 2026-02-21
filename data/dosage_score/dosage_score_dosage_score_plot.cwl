cwlVersion: v1.2
class: CommandLineTool
baseCommand: dosage_score_plot
label: dosage_score_dosage_score_plot
doc: "A tool for plotting dosage scores. (Note: The provided help text contains only
  container runtime error messages and no usage information.)\n\nTool homepage: https://github.com/SegawaTenta/Dosage-score"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dosage_score:1.0.0--pyhdfd78af_0
stdout: dosage_score_dosage_score_plot.out
