cwlVersion: v1.2
class: CommandLineTool
baseCommand: bpp-seq
label: bpp-seq
doc: "Bio++ Sequence library command-line tool (No description available in provided
  text)\n\nTool homepage: https://github.com/BioPP/bpp-seq"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bpp-seq:2.4.1--h9948957_5
stdout: bpp-seq.out
