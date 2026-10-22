cwlVersion: v1.2
class: CommandLineTool
baseCommand: fasta2revcom.pl
label: snpgenie_fasta2revcom.pl
doc: "Converts a '+' strand FASTA file to its reverse complement.\n\nTool homepage: https://github.com/chasewnelson/SNPGenie"
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
  - id: revcom_files
    type:
      type: array
      items: File
    doc: Reverse complement FASTA file (<name>_revcom.fasta)
    outputBinding:
      glob: "*_revcom.fasta"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snpgenie:1.0--hdfd78af_1
stdout: snpgenie_fasta2revcom.pl.out
