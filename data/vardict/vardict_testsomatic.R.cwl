cwlVersion: v1.2
class: CommandLineTool
baseCommand: testsomatic.R
label: vardict_testsomatic.R
doc: 'Test somatic status of paired VarDict output with Fisher exact test (reads the
  paired vardict table on standard input).


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
stdout: testsomatic.R.out
