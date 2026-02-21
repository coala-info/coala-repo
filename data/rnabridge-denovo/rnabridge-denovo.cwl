cwlVersion: v1.2
class: CommandLineTool
baseCommand: rnabridge-denovo
label: rnabridge-denovo
doc: "RNAbridge-denovo is a tool for transcriptome assembly. (Note: The provided text
  contains container build logs rather than the tool's help documentation, so no arguments
  could be extracted.)\n\nTool homepage: https://github.com/Shao-Group/rnabridge-denovo"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnabridge-denovo:1.0.1--hc9558a2_0
stdout: rnabridge-denovo.out
