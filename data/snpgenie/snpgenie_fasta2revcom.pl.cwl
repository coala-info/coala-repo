cwlVersion: v1.2
class: CommandLineTool
baseCommand: snpgenie_fasta2revcom.pl
label: snpgenie_fasta2revcom.pl
doc: "Converts a '+' strand FASTA file to its reverse complement.\n\nTool homepage:
  https://github.com/chasewnelson/SNPGenie"
inputs:
  - id: fasta_file
    type: File
    doc: A '+' strand FASTA file
    inputBinding:
      position: 1
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_fasta2revcom.pl.out
