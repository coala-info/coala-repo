cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mrsfast
  - --index
label: mrsfast_index
doc: "Index a reference genome for mrsFAST (mrsfast --index). The index is written
  beside the FASTA as <reference>.index.\n\nTool homepage: https://github.com/sfu-compbio/mrsfast"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference)
        writable: true
inputs:
  - id: reference
    type: File
    doc: Reference genome FASTA file to index.
    inputBinding:
      position: 1
  - id: window_size
    type:
      - 'null'
      - int
    doc: 'Index the reference genome with sliding a window of size window_size (default: 12).'
    inputBinding:
      position: 2
      prefix: --ws
outputs:
  - id: index
    type: File
    doc: The reference FASTA with its mrsFAST index (reference.index) as secondary file.
    outputBinding:
      glob: $(inputs.reference.basename)
    secondaryFiles:
      - pattern: .index
        required: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrsfast:3.4.2--h7132678_2
