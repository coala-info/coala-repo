cwlVersion: v1.2
class: CommandLineTool
baseCommand: cesar_formatGenePred.pl
label: cesar_formatGenePred.pl
doc: "A script to format GenePred files for use with CESAR. (Note: The provided help
  text contains container execution errors and does not list specific arguments.)\n
  \nTool homepage: https://github.com/hillerlab/CESAR2.0"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cesar:1.01--h503566f_3
stdout: cesar_formatGenePred.pl.out
