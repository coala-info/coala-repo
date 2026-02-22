cwlVersion: v1.2
class: CommandLineTool
baseCommand: ctc-scite
label: ctc-scite
doc: "A tool for Single-cell Inference of Tumor Evolution. (Note: The provided text
  appears to be a container build error log rather than help text, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/cbg-ethz/CTC-SCITE"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ctc-scite:1.0.2--h9948957_0
stdout: ctc-scite.out
