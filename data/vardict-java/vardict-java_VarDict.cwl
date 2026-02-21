cwlVersion: v1.2
class: CommandLineTool
baseCommand: VarDict
label: vardict-java_VarDict
doc: "VarDict is a variant caller for DNA sequence data. (Note: The provided help
  text contains only system error messages and does not list command-line arguments.)\n
  \nTool homepage: https://github.com/AstraZeneca-NGS/VarDictJava"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict-java:1.8.3--hdfd78af_0
stdout: vardict-java_VarDict.out
