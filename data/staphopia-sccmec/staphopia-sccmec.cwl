cwlVersion: v1.2
class: CommandLineTool
baseCommand: staphopia-sccmec
label: staphopia-sccmec
doc: "A tool for SCCmec typing of Staphylococcus aureus (Note: The provided text is
  a container build error log and does not contain usage information or argument definitions).\n
  \nTool homepage: https://github.com/staphopia/staphopia-sccmec"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/staphopia-sccmec:1.0.0--hdfd78af_0
stdout: staphopia-sccmec.out
