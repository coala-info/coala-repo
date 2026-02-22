cwlVersion: v1.2
class: CommandLineTool
baseCommand: pcst-fast
label: pcst-fast
doc: "The provided text contains system error messages related to a container execution
  failure (no space left on device) and does not contain the help documentation or
  usage instructions for the pcst-fast tool. As a result, no arguments could be extracted.\n\
  \nTool homepage: https://github.com/fraenkel-lab/pcst_fast"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pcst-fast:1.0.10--py310h84f13bb_1
stdout: pcst-fast.out
