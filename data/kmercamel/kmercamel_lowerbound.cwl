cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - kmercamel
  - lowerbound
label: kmercamel_lowerbound
doc: "Calculates the lower bound of the number of unique k-mers in a FASTA file.\n\
  \nTool homepage: https://github.com/OndrejSladky/kmercamel/"
inputs:
  - id: fasta
    type: File
    doc: Path to the FASTA file
    inputBinding:
      position: 1
  - id: kmer_size
    type: int
    doc: k-mer size
    inputBinding:
      position: 102
      prefix: -k
  - id: treat_reverse_complement_distinct
    type:
      - 'null'
      - boolean
    doc: treat k-mer and its reverse complement as distinct
    inputBinding:
      position: 102
      prefix: -u
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmercamel:2.2.0--ha119d93_0
stdout: kmercamel_lowerbound.out
