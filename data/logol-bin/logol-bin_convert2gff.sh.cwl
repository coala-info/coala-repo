cwlVersion: v1.2
class: CommandLineTool
baseCommand: logol-bin_convert2gff.sh
label: logol-bin_convert2gff.sh
doc: "A tool to convert Logol output to GFF format. (Note: The provided help text
  contains container runtime error messages and does not list specific command-line
  arguments).\n\nTool homepage: https://github.com/genouest/logol"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/logol-bin:v1.7.9-1-deb_cv1
stdout: logol-bin_convert2gff.sh.out
