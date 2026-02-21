cwlVersion: v1.2
class: CommandLineTool
baseCommand: crisper_recognition_tool
label: crisper_recognition_tool
doc: "CRISPR Recognition Tool (Note: The provided text contains only system logs and
  an execution error; no help documentation or arguments were found in the input).\n
  \nTool homepage: http://www.room220.com/crt/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/crisper_recognition_tool:1.2--py35_0
stdout: crisper_recognition_tool.out
