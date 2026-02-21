cwlVersion: v1.2
class: CommandLineTool
baseCommand: get_fasta_info
label: get_fasta_info
doc: "A tool to extract information from FASTA files (Note: The provided help text
  contains only system error messages and no usage information).\n\nTool homepage:
  https://github.com/nylander/get_fasta_info"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/get_fasta_info:2.5.0--h577a1d6_0
stdout: get_fasta_info.out
