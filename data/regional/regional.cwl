cwlVersion: v1.2
class: CommandLineTool
baseCommand: regional
label: regional
doc: "A tool for regional analysis (Note: The provided text contains error logs from
  a container build process rather than the tool's help documentation. No arguments
  could be extracted from the input.)\n\nTool homepage: https://github.com/freeman-lab/regional"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/regional:1.1.2--py_0
stdout: regional.out
