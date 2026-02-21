cwlVersion: v1.2
class: CommandLineTool
baseCommand: snver
label: snver
doc: "SNVer is a statistical tool for variant calling from next-generation sequencing
  data. (Note: The provided text contains container environment logs and execution
  errors rather than the tool's help documentation.)\n\nTool homepage: http://snver.sourceforge.net/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snver:0.5.3--0
stdout: snver.out
