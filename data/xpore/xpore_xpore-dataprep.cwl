cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - xpore
  - dataprep
label: xpore_xpore-dataprep
doc: "Data preprocessing for xPore (Note: The provided help text contains system logs
  and error messages rather than tool usage information).\n\nTool homepage: https://github.com/GoekeLab/xpore"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/xpore:2.1--pyh5e36f6f_0
stdout: xpore_xpore-dataprep.out
