cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - lordfast
  - --index
label: lordfast_index
doc: "Index a reference genome (FASTA) for lordFAST long read mapping. The index files are written beside the reference.\n\nTool homepage: https://github.com/vpc-ccg/lordfast"
inputs:
  - id: reference
    type: File
    doc: Path to the reference genome file in FASTA format which is supposed to be indexed.
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
outputs:
  - id: indexed_reference
    type: File
    doc: The reference FASTA with its lordFAST index files.
    secondaryFiles:
      - pattern: .amb
        required: true
      - pattern: .ann
        required: true
      - pattern: .bwt
        required: true
      - pattern: .cache
        required: true
      - pattern: .pac
        required: true
      - pattern: .sa
        required: true
    outputBinding:
      glob: $(inputs.reference.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.reference)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/lordfast:0.0.10--h5b5514e_3
