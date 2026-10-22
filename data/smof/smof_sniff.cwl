cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smof
  - sniff
label: smof_sniff
doc: "Identify the sequence type and aid in diagnostics.\n\nTool homepage: https://github.com/incertae-sedis/smof"
inputs:
  - id: input_file
    type: File
    doc: "Input FASTA file (smof reads standard input by default)"
    inputBinding:
      position: 200
outputs:
  - id: stdout
    type: stdout
    doc: "Standard output"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smof:2.22.4--pyhdfd78af_0
stdout: smof_sniff.out
