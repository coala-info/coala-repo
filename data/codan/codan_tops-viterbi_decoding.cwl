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
    type: File
    doc: a decodable model
    inputBinding:
      position: 101
      prefix: --model
  - id: sequences
    type: File
    doc: input sequences, read from standard input (ToPS sequence format, or 
      FASTA with --fasta)
  - id: model_files
    type:
      - 'null'
      - Directory
    doc: folder with the sub-models that the model file names; it is staged in 
      the working directory so relative names such as 
      <folder>/model/cds.model resolve
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.model_files)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/codan:1.2--hdfd78af_1
stdin: $(inputs.sequences.path)
stdout: codan_tops-viterbi_decoding.out
