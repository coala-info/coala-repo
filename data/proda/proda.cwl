cwlVersion: v1.2
class: CommandLineTool
baseCommand: proda
label: proda
doc: "ProDA aligns multiple protein sequences, allowing for local repeats and rearrangements (probabilistic alignment with duplications).\n\nTool homepage: http://proda.stanford.edu/"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing: '$(inputs.filenames.map(function(f){ return {"entry": f, "writable": true}; }))'
inputs:
  - id: filenames
    type: File[]
    doc: "Input sequence files (FASTA/MFA)"
    inputBinding:
      position: 10
  - id: min_block_length
    type:
      - 'null'
      - int
    doc: "Minimal block length"
    inputBinding:
      position: 1
      prefix: -L
  - id: silent
    type:
      - 'null'
      - boolean
    doc: "Do not print progress messages"
    inputBinding:
      position: 1
      prefix: -silent
  - id: posterior
    type:
      - 'null'
      - boolean
    doc: "Output posterior probabilities"
    inputBinding:
      position: 1
      prefix: -posterior
  - id: tran
    type:
      - 'null'
      - boolean
    doc: "Output transition probabilities"
    inputBinding:
      position: 1
      prefix: -tran
  - id: fasta
    type:
      - 'null'
      - boolean
    doc: "FASTA format option from the usage line"
    inputBinding:
      position: 1
      prefix: -fasta
outputs:
  - id: stdout
    type: stdout
    doc: Alignment printed to standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/proda:1.0--hdbdd923_5
stdout: proda.out
