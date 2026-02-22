cwlVersion: v1.2
class: CommandLineTool
baseCommand: breakseq2
label: breakseq2
doc: "No description available from the provided text.\n\nTool homepage: http://bioinform.github.io/breakseq2"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/breakseq2:2.2--py27_0
stdout: breakseq2.out
