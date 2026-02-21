cwlVersion: v1.2
class: CommandLineTool
baseCommand: cite-seq-count
label: cite-seq-count
doc: "The provided text is a system error log related to a container build failure
  (no space left on device) and does not contain the tool's help text or argument
  definitions.\n\nTool homepage: https://hoohm.github.io/CITE-seq-Count/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cite-seq-count:1.4.5--pyhdfd78af_0
stdout: cite-seq-count.out
