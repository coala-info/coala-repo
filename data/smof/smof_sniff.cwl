cwlVersion: v1.2
class: CommandLineTool
baseCommand: smof_sniff
label: smof_sniff
doc: "Identifies the sequence type and aids in diagnostics.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: input_fasta
    type:
      - 'null'
      - File
    doc: input fasta sequence
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_sniff.out
