cwlVersion: v1.2
class: CommandLineTool
baseCommand: snapgene-reader
label: snapgene-reader
doc: "A tool to read SnapGene files (.dna or .prot)\n\nTool homepage: https://pypi.org/project/snapgene-reader/"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snapgene-reader:0.1.23--pyhdfd78af_0
stdout: snapgene-reader.out
