cwlVersion: v1.2
class: CommandLineTool
baseCommand: ncbitk
label: ncbitk
doc: "NCBI ToolKit (No description available from the provided error log)\n\nTool
  homepage: https://github.com/andrewsanchez/NCBITK"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ncbitk:1.0a17--py_0
stdout: ncbitk.out
