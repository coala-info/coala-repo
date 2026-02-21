cwlVersion: v1.2
class: CommandLineTool
baseCommand: isoplot
label: isoplot
doc: "The provided text is a system error message indicating a failure to pull or
  build the container image due to lack of disk space; it does not contain the tool's
  help documentation or argument definitions.\n\nTool homepage: https://github.com/LoloPopoPy/Isoplot"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/isoplot:1.3.1--pyh5e36f6f_0
stdout: isoplot.out
