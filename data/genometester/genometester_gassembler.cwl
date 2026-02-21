cwlVersion: v1.2
class: CommandLineTool
baseCommand: gAssembler
label: genometester_gassembler
doc: "A tool for genome assembly and k-mer analysis. (Note: The provided help text
  contains only system error messages regarding container execution and does not list
  specific command-line arguments.)\n\nTool homepage: https://github.com/bioinfo-ut/GenomeTester4"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/genometester:v4.0git20180508.a9c14a6dfsg-1-deb_cv1
stdout: genometester_gassembler.out
