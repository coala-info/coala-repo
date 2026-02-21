cwlVersion: v1.2
class: CommandLineTool
baseCommand: tophat-recondition.py
label: tophat-recondition_tophat-recondition.py
doc: "A post-processor for TopHat unmapped reads. (Note: The provided text contains
  container build logs rather than tool help text, so no arguments could be extracted.)\n
  \nTool homepage: https://github.com/cbrueffer/tophat-recondition"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tophat-recondition:1.4--py35_0
stdout: tophat-recondition_tophat-recondition.py.out
