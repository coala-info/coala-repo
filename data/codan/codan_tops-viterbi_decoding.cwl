cwlVersion: v1.2
class: CommandLineTool
baseCommand: tops-viterbi_decoding
label: codan_tops-viterbi_decoding
doc: "ToPS Viterbi decoding tool\n\nTool homepage: https://github.com/pedronachtigall/CodAn"
inputs:
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: use fasta format
    inputBinding:
      position: 101
      prefix: --fasta
  - id: model
    type:
      - 'null'
      - File
    doc: a decodable model
    inputBinding:
      position: 101
      prefix: --model
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/codan:1.2--hdfd78af_1
stdout: codan_tops-viterbi_decoding.out
