cwlVersion: v1.2
class: CommandLineTool
baseCommand: simscsntree
label: simscsntree
doc: "A tool for simulating single-cell SNV (Single Nucleotide Variant) trees.\n\n
  Tool homepage: https://github.com/compbiofan/SimSCSnTree"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/simscsntree:0.0.9--pyh5e36f6f_0
stdout: simscsntree.out
