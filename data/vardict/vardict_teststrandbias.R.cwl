cwlVersion: v1.2
class: CommandLineTool
baseCommand: teststrandbias.R
label: vardict_teststrandbias.R
doc: 'Test strand bias of VarDict variants with Fisher exact test (reads the vardict
  table on standard input, second step of the VarDict pipeline).


  Tool homepage: https://github.com/AstraZeneca-NGS/VarDict'
inputs:
  - id: input_file
    type: File
    doc: Variant table written by vardict (read on standard input).
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict:2019.06.04--pl526_0
stdin: $(inputs.input_file.path)
stdout: teststrandbias.R.out
