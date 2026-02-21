cwlVersion: v1.2
class: CommandLineTool
baseCommand: glpk
label: glpk
doc: "GNU Linear Programming Kit (Note: The provided text is a system error log indicating
  a failure to build the container image due to insufficient disk space and does not
  contain the tool's help documentation.)\n\nTool homepage: https://github.com/hgourvest/glpk.js"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/glpk:4.57--0
stdout: glpk.out
