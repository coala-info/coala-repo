cwlVersion: v1.2
class: CommandLineTool
baseCommand: epicore
label: epicore_generate-epicore-csv
doc: "epicore\n\nTool homepage: https://github.com/AG-Walz/epicore"
inputs:
  - id: reference_proteome
    type: string
    doc: Reference proteome FASTA file
    inputBinding:
      position: 101
      prefix: --reference_proteome
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/epicore:0.1.7--pyhdfd78af_0
stdout: epicore_generate-epicore-csv.out
