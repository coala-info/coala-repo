cwlVersion: v1.2
class: CommandLineTool
baseCommand: pqlseqpy
label: pqlseqpy
doc: "PQLseq (Parallelized Mixed Model Association Test) for Python. Note: The provided
  text contains system logs and error messages rather than CLI help documentation,
  so no arguments could be extracted.\n\nTool homepage: https://github.com/mokar2001/PQLseqPy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pqlseqpy:0.1.2--pyh7e72e81_0
stdout: pqlseqpy.out
