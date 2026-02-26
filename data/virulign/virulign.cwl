cwlVersion: v1.2
class: CommandLineTool
baseCommand: virulign
label: virulign
doc: "Aligns sequences to a reference genome, identifying mutations and structural
  variations.\n\nTool homepage: https://github.com/rega-cev/virulign"
inputs:
  - id: reference
    type: File
    doc: Reference FASTA file or ORF description XML file
    inputBinding:
      position: 1
  - id: sequences
    type: File
    doc: Sequences FASTA file to align
    inputBinding:
      position: 2
  - id: export_alphabet
    type:
      - 'null'
      - string
    doc: 'Alphabet for export: AminoAcids, Nucleotides'
    default: AminoAcids
    inputBinding:
      position: 103
      prefix: --exportAlphabet
  - id: export_kind
    type:
      - 'null'
      - string
    doc: 'Type of export: Mutations, PairwiseAlignments, GlobalAlignment, PositionTable,
      MutationTable'
    default: Mutations
    inputBinding:
      position: 103
      prefix: --exportKind
  - id: export_reference_sequence
    type:
      - 'null'
      - boolean
    doc: 'Include reference sequence in the export: yes or no'
    default: no
    inputBinding:
      position: 103
      prefix: --exportReferenceSequence
  - id: export_with_insertions
    type:
      - 'null'
      - boolean
    doc: 'Include insertions in the export: yes or no'
    default: no
    inputBinding:
      position: 103
      prefix: --exportWithInsertions
  - id: gap_extension_penalty
    type:
      - 'null'
      - float
    doc: Penalty for extending a gap
    default: 3.3
    inputBinding:
      position: 103
      prefix: --gapExtensionPenalty
  - id: gap_open_penalty
    type:
      - 'null'
      - float
    doc: Penalty for opening a gap
    default: 10.0
    inputBinding:
      position: 103
      prefix: --gapOpenPenalty
  - id: max_frame_shifts
    type:
      - 'null'
      - int
    doc: Maximum number of allowed frame shifts
    default: 3
    inputBinding:
      position: 103
      prefix: --maxFrameShifts
  - id: nt_debug_directory
    type:
      - 'null'
      - Directory
    doc: Directory for nucleotide debug output
    inputBinding:
      position: 103
      prefix: --nt-debug
  - id: progress
    type:
      - 'null'
      - boolean
    doc: 'Show progress: yes or no'
    default: no
    inputBinding:
      position: 103
      prefix: --progress
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    default: all cpus available
    inputBinding:
      position: 103
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virulign:1.1.1--hf316886_6
stdout: virulign.out
