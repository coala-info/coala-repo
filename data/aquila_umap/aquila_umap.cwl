cwlVersion: v1.2
class: CommandLineTool
baseCommand: aquila_umap
label: aquila_umap
doc: "The provided text is a system error log regarding a container build failure
  (no space left on device) and does not contain the help documentation or usage instructions
  for the tool.\n\nTool homepage: https://github.com/maiziex/Aquila_Umap"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/aquila:1.0.0--py_0
stdout: aquila_umap.out
