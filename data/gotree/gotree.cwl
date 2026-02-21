cwlVersion: v1.2
class: CommandLineTool
baseCommand: gotree
label: gotree
doc: "The provided text is an error log indicating a failure to pull or build the
  container image (no space left on device) and does not contain help information
  or argument definitions.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
stdout: gotree.out
