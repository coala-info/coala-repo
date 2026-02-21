cwlVersion: v1.2
class: CommandLineTool
baseCommand: testsomatic.R
label: vardict-java_testsomatic.R
doc: "Somatic mutation testing script for VarDict. (Note: The provided text contains
  container execution logs and error messages rather than command-line help documentation;
  therefore, no arguments could be extracted.)\n\nTool homepage: https://github.com/AstraZeneca-NGS/VarDictJava"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
stdout: vardict-java_testsomatic.R.out
