cwlVersion: v1.2
class: CommandLineTool
baseCommand: lusstr
label: lusstr
doc: "A tool for analyzing CLI help text (Note: The provided input contains system
  error messages rather than tool help text).\n\nTool homepage: https://www.github.com/bioforensics/lusSTR"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lusstr:0.11--pyhdfd78af_0
stdout: lusstr.out
