cwlVersion: v1.2
class: CommandLineTool
baseCommand: danbing-tk-pred
label: danbing-tk_danbing-tk-pred
doc: "A tool from the danbing-tk suite (Note: The provided help text contains only
  container runtime error logs and no usage information).\n\nTool homepage: https://github.com/ChaissonLab/danbing-tk"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/danbing-tk:1.3.2.5--h9948957_0
stdout: danbing-tk_danbing-tk-pred.out
