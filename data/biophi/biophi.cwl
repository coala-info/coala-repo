cwlVersion: v1.2
class: CommandLineTool
baseCommand: biophi
label: biophi
doc: "BioPhi: A platform for antibody design and humanization (Note: The provided
  text contains system error messages rather than help text; no arguments could be
  extracted).\n\nTool homepage: https://github.com/Merck/BioPhi"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/biophi:1.0.10--pyhdfd78af_2
stdout: biophi.out
