cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyhmmer
  - phmmer
label: pyhmmer_phmmer
doc: "Search a protein sequence against a protein sequence database using the HMMER
  phmmer algorithm.\n\nTool homepage: https://github.com/althonos/pyhmmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyhmmer:0.12.0--py313h366bbf7_0
stdout: pyhmmer_phmmer.out
