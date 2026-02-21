cwlVersion: v1.2
class: CommandLineTool
baseCommand: canvas
label: canvas
doc: "Canvas is a tool for calling copy number variants from NGS data. (Note: The
  provided text contains container build logs and error messages rather than help
  text; no arguments could be extracted from the input.)\n\nTool homepage: https://github.com/Illumina/canvas"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/canvas:1.35.1.1316--0
stdout: canvas.out
