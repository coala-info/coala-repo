cwlVersion: v1.2
class: CommandLineTool
baseCommand: mantis
label: mantis_pfa_mantis check
doc: "Mantis is a k-mer based sequence analysis tool.\n\nTool homepage: https://github.com/PedroMTQ/Mantis"
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print version information and exit.
    inputBinding:
      position: 101
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mantis:0.2--h4a1dfb3_4
stdout: mantis_pfa_mantis check.out
