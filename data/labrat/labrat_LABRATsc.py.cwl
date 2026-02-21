cwlVersion: v1.2
class: CommandLineTool
baseCommand: labrat_LABRATsc.py
label: labrat_LABRATsc.py
doc: "LABRAT (Log-Average Ratio of Alternative Transcript) for single-cell analysis.
  Note: The provided text contains only container runtime error messages and no usage
  information; therefore, no arguments could be extracted.\n\nTool homepage: https://github.com/TaliaferroLab/LABRAT"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/labrat:0.3.0--pyhdfd78af_1
stdout: labrat_LABRATsc.py.out
