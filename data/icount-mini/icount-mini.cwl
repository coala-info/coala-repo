cwlVersion: v1.2
class: CommandLineTool
baseCommand: icount-mini
label: icount-mini
doc: "iCount-mini is a computational pipeline for the analysis of iCLIP data. (Note:
  The provided text is an error message indicating a failure to pull the container
  image due to lack of disk space and does not contain help documentation.)\n\nTool
  homepage: https://github.com/ulelab/iCount-Mini"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/icount-mini:3.0.1--pyh7cba7a3_0
stdout: icount-mini.out
