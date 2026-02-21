cwlVersion: v1.2
class: CommandLineTool
baseCommand: clipcontext
label: clipcontext
doc: "A tool for CLIP-seq data analysis. (Note: The provided input text is a system
  error log regarding a container build failure and does not contain the actual command-line
  help documentation or argument definitions.)\n\nTool homepage: https://github.com/BackofenLab/CLIPcontext"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/clipcontext:0.7--py_0
stdout: clipcontext.out
