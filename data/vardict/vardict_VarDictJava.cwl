cwlVersion: v1.2
class: CommandLineTool
baseCommand: VarDict
label: vardict_VarDictJava
doc: "VarDict is a variant caller for DNA and RNA sequencing data. Note: The provided
  text appears to be a container runtime error log rather than help text, so no arguments
  could be extracted.\n\nTool homepage: https://github.com/AstraZeneca-NGS/VarDict"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vardict:2019.06.04--pl526_0
stdout: vardict_VarDictJava.out
