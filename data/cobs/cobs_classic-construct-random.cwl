cwlVersion: v1.2
class: CommandLineTool
baseCommand: cobs classic-construct-random
label: cobs_classic-construct-random
doc: "Constructs a random COBS index.\n\nTool homepage: https://panthema.net/cobs"
inputs:
  - id: out_file
    type: File
    doc: path to the output file
    inputBinding:
      position: 1
  - id: document_size
    type:
      - 'null'
      - int
    doc: number of random 31-mers in document
    inputBinding:
      position: 102
      prefix: --document-size
  - id: num_documents
    type:
      - 'null'
      - int
    doc: number of random documents in index
    inputBinding:
      position: 102
      prefix: --num-documents
  - id: num_hashes
    type:
      - 'null'
      - int
    doc: number of hash functions
    inputBinding:
      position: 102
      prefix: --num-hashes
  - id: seed
    type:
      - 'null'
      - int
    doc: random seed
    inputBinding:
      position: 102
      prefix: --seed
  - id: signature_size
    type:
      - 'null'
      - string
    doc: number of bits of the signatures (vertical size)
    inputBinding:
      position: 102
      prefix: --signature-size
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cobs:0.3.1--hdcf5f25_0
stdout: cobs_classic-construct-random.out
