cwlVersion: v1.2
class: CommandLineTool
baseCommand: teststrandbias.R
label: vardict-java_teststrandbias.R
doc: 'Test strand bias of variants with Fisher exact test (reads vardict output on
  standard input, as the second step of the VarDict pipeline).


  Tool homepage: https://github.com/AstraZeneca-NGS/VarDictJava'
inputs:
  - id: input_file
    type: File
    doc: Variant table written by vardict-java (read on standard input).
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
stdin: $(inputs.input_file.path)
stdout: teststrandbias.R.out
