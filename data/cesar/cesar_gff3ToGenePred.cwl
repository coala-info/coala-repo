cwlVersion: v1.2
class: CommandLineTool
baseCommand: cesar_gff3ToGenePred
label: cesar_gff3ToGenePred
doc: "A tool to convert GFF3 format to GenePred format. (Note: The provided help text
  contains system error messages regarding container extraction and does not list
  command-line arguments.)\n\nTool homepage: https://github.com/hillerlab/CESAR2.0"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cesar:1.01--h503566f_3
stdout: cesar_gff3ToGenePred.out
