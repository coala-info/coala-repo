cwlVersion: v1.2
class: CommandLineTool
baseCommand: remag
label: remag
doc: "No description available\n\nTool homepage: https://github.com/danielzmbp/remag"
inputs:
  - id: fasta_arg
    type:
      - 'null'
      - File
    doc: FASTA file argument
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/remag:0.3.4--pyhdfd78af_0
stdout: remag.out
