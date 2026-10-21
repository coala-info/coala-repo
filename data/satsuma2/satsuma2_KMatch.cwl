cwlVersion: v1.2
class: CommandLineTool
baseCommand: [KMatch]
label: satsuma2_KMatch
doc: "Finds matching k-mer blocks between a query and a target FASTA file and dumps them to a binary match file (usage: KMatch query.fa target.fa K output.fa min_length jump max_freq).\n\nTool homepage: https://github.com/bioinfologics/satsuma2"
inputs:
  - id: query_fasta
    type: File
    doc: "query FASTA file (query.fa)"
    inputBinding:
      position: 1
  - id: target_fasta
    type: File
    doc: "target FASTA file (target.fa)"
    inputBinding:
      position: 2
  - id: k
    type: int
    doc: "k-mer length; must be odd (K)"
    inputBinding:
      position: 3
  - id: output_file
    type: string
    doc: "output file name, binary match file (output.fa)"
    inputBinding:
      position: 4
  - id: min_length
    type: int
    doc: "minimum match length (min_length)"
    inputBinding:
      position: 5
  - id: jump
    type: int
    doc: "maximum jump between consecutive k-mers (jump)"
    inputBinding:
      position: 6
  - id: max_freq
    type: int
    doc: "maximum frequency of a k-mer (max_freq)"
    inputBinding:
      position: 7
outputs:
  - id: matches
    type: File
    doc: "Binary match file"
    outputBinding:
      glob: "$(inputs.output_file)"
  - id: log
    type: stdout
    doc: "Standard output of the program"
stdout: kmatch.log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/satsuma2:20161123--1
