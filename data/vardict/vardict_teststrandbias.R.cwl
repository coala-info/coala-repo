cwlVersion: v1.2
class: CommandLineTool
baseCommand: teststrandbias.R
label: vardict_teststrandbias.R
doc: "A script typically used in the VarDict pipeline to test for strand bias.\n\n
  Tool homepage: https://github.com/AstraZeneca-NGS/VarDict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict:2019.06.04--pl526_0
stdout: vardict_teststrandbias.R.out
