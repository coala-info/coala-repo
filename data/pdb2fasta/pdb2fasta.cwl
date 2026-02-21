cwlVersion: v1.2
class: CommandLineTool
baseCommand: pdb2fasta
label: pdb2fasta
doc: "Convert a PDB file to a FASTA sequence format. Output is printed to stdout.\n
  \nTool homepage: https://github.com/kad-ecoli/pdb2fasta"
inputs:
  - id: pdb_file
    type: File
    doc: Input PDB file to be converted
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pdb2fasta:1.0--h7b50bb2_0
stdout: pdb2fasta.out
