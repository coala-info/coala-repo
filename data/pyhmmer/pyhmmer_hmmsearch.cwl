cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pyhmmer
  - hmmsearch
label: pyhmmer_hmmsearch
doc: "Search profile HMM(s) against a sequence database. (Note: The provided help
  text contains only system error logs and does not list specific tool arguments.)\n
  \nTool homepage: https://github.com/althonos/pyhmmer"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pyhmmer:0.12.0--py313h366bbf7_0
stdout: pyhmmer_hmmsearch.out
