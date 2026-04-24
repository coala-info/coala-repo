cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - rustybam
  - get-fasta
label: rustybam_get-fasta
doc: "Mimic bedtools getfasta but allow for bgzip in both bed and fasta inputs\n\n\
  Tool homepage: https://github.com/mrvollger/rustybam"
inputs:
  - id: bed
    type: File
    doc: BED file of regions to extract
    inputBinding:
      position: 101
      prefix: --bed
  - id: fasta
    type:
      - 'null'
      - File
    doc: Fasta file to extract sequences from
    inputBinding:
      position: 101
      prefix: --fasta
  - id: name
    type:
      - 'null'
      - boolean
    doc: Add the name (4th column) to the header of the fasta output
    inputBinding:
      position: 101
      prefix: --name
  - id: strand
    type:
      - 'null'
      - boolean
    doc: Reverse complement the sequence if the strand is "-"
    inputBinding:
      position: 101
      prefix: --strand
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rustybam:0.1.34--hf24ce72_0
stdout: rustybam_get-fasta.out
