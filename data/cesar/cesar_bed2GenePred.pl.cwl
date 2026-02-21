cwlVersion: v1.2
class: CommandLineTool
baseCommand: cesar_bed2GenePred.pl
label: cesar_bed2GenePred.pl
doc: "A tool to convert BED files to GenePred format (Note: The provided help text
  contains a system error log and does not list specific arguments).\n\nTool homepage:
  https://github.com/hillerlab/CESAR2.0"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cesar:1.01--h503566f_3
stdout: cesar_bed2GenePred.pl.out
