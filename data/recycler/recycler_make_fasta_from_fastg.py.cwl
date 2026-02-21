cwlVersion: v1.2
class: CommandLineTool
baseCommand: recycler_make_fasta_from_fastg.py
label: recycler_make_fasta_from_fastg.py
doc: "A script to convert FASTG files to FASTA format, typically used as part of the
  Recycler assembly tool pipeline.\n\nTool homepage: https://github.com/Shamir-Lab/Recycler"
inputs: []
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/recycler:0.7--py27h24bf2e0_2
stdout: recycler_make_fasta_from_fastg.py.out
