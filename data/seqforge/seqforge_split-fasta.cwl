cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - seqforge
  - split-fasta
label: seqforge_split-fasta
doc: "Split a multi-FASTA into per-record files or fixed-size fragments.\n\nTool homepage:
  https://github.com/ERBringHorvath/SeqForge"
inputs:
  - id: compress
    type:
      - 'null'
      - boolean
    doc: Compress output files as .gz
    inputBinding:
      position: 101
      prefix: --compress
  - id: fasta
    type: File
    doc: Input multi-FASTA file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: fragment
    type:
      - 'null'
      - int
    doc: Split multi-FASTA into chunks of this many sequences
    inputBinding:
      position: 101
      prefix: --fragment
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory for split FASTA files
    outputBinding:
      glob: $(inputs.output_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seqforge:2.0.0--pyh7e72e81_0
