cwlVersion: v1.2
class: CommandLineTool
baseCommand: LABRAT.py
label: labrat_LABRAT.py
doc: "LABRAT (Log-linear Alternative Bin-based Relative Analysis of Transcription)
  is a tool for alternative polyadenylation (APA) analysis.\n\nTool homepage: https://github.com/TaliaferroLab/LABRAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/labrat:0.3.0--pyhdfd78af_1
stdout: labrat_LABRAT.py.out
