cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie_snpgenie_within_group.pl
label: snpgenie_snpgenie_within_group.pl
doc: "SNPGenie terminated.\n\nTool homepage: https://github.com/chasewnelson/SNPGenie"
inputs:
  - id: fasta_file_name
    type:
      - 'null'
      - File
    doc: The --fasta_file_name option must be a file with a .fa or .fasta 
      extension
    inputBinding:
      position: 101
      prefix: --fasta_file_name
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_snpgenie_within_group.pl.out
