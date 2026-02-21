cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpiphy
label: snpiphy
doc: "SNP-based phylogeny tool (Note: The provided text contains container build logs
  and error messages rather than command-line help documentation, so no arguments
  could be extracted).\n\nTool homepage: https://github.com/bogemad/snpiphy"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpiphy:0.5--py_0
stdout: snpiphy.out
