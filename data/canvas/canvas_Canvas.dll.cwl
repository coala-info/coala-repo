cwlVersion: v1.2
class: CommandLineTool
baseCommand: canvas_Canvas.dll
label: canvas_Canvas.dll
doc: "Canvas is a tool for calling copy number variants from human DNA sequencing
  data.\n\nTool homepage: https://github.com/Illumina/canvas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/canvas:1.35.1.1316--0
stdout: canvas_Canvas.dll.out
