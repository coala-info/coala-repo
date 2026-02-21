cwlVersion: v1.2
class: CommandLineTool
baseCommand: pybbi
label: pybbi
doc: "A Python interface to BigWig and BigBed files (Note: The provided help text
  contains only system logs and no usage information).\n\nTool homepage: https://github.com/nvictus/pybbi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pybbi:0.4.2--py39h2d95d83_0
stdout: pybbi.out
