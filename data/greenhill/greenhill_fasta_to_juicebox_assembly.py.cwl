cwlVersion: v1.2
class: CommandLineTool
baseCommand: greenhill_fasta_to_juicebox_assembly.py
label: greenhill_fasta_to_juicebox_assembly.py
doc: "A tool to convert FASTA files to Juicebox assembly format.\n\nTool homepage:
  https://github.com/ShunOuchi/GreenHill"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/greenhill:1.1.0--h663a4a6_3
stdout: greenhill_fasta_to_juicebox_assembly.py.out
