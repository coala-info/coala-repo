cwlVersion: v1.2
class: CommandLineTool
baseCommand: whatsgnu
label: whatsgnu
doc: "A tool for identifying orthologous genes using a BLAST-based approach against
  a reference database.\n\nTool homepage: https://github.com/ahmedmagds/WhatsGNU"
inputs:
  - id: coverage
    type:
      - 'null'
      - float
    doc: Minimum query coverage for BLAST hits
    default: 50.0
    inputBinding:
      position: 101
      prefix: --coverage
  - id: database
    type: Directory
    doc: Path to the reference database directory
    inputBinding:
      position: 101
      prefix: --database
  - id: evalue
    type:
      - 'null'
      - float
    doc: E-value threshold for BLAST hits
    default: 1e-05
    inputBinding:
      position: 101
      prefix: --evalue
  - id: genome
    type: File
    doc: Input genome file in FASTA format
    inputBinding:
      position: 101
      prefix: --genome
  - id: max_target_seqs
    type:
      - 'null'
      - int
    doc: Maximum number of target sequences to keep
    default: 10
    inputBinding:
      position: 101
      prefix: --max_target_seqs
  - id: percent_identity
    type:
      - 'null'
      - float
    doc: Minimum percent identity for BLAST hits
    default: 40.0
    inputBinding:
      position: 101
      prefix: --percent_identity
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use for BLAST
    default: 1
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type:
      - 'null'
      - File
    doc: Output file name for the results
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/whatsgnu:1.5--hdfd78af_0
