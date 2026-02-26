cwlVersion: v1.2
class: CommandLineTool
baseCommand: tgv_list
label: tgv_list
doc: "Browse a genome: tgv -g <genome> (e.g. tgv -g rat)\n\nTool homepage: https://github.com/zeqianli/tgv"
inputs:
  - id: genome
    type: string
    doc: Specify the genome to browse
    inputBinding:
      position: 101
      prefix: -g
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/tgv:0.1.0--h521fa98_0
stdout: tgv_list.out
