cwlVersion: v1.2
class: CommandLineTool
baseCommand: vardict_testsomatic.R
label: vardict_testsomatic.R
doc: "No description available: The provided text contains system error logs rather
  than help documentation.\n\nTool homepage: https://github.com/AstraZeneca-NGS/VarDict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict:2019.06.04--pl526_0
stdout: vardict_testsomatic.R.out
