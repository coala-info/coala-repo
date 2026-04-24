cwlVersion: v1.2
class: CommandLineTool
baseCommand: stringdecomposer
label: stringdecomposer
doc: "Decompose long sequences into blocks using a set of monomers.\n\nTool homepage:
  https://github.com/ablab/stringdecomposer"
inputs:
  - id: sequence_file
    type: File
    doc: FASTA file with sequences to decompose
    inputBinding:
      position: 1
  - id: monomers_file
    type: File
    doc: FASTA file with monomers
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    inputBinding:
      position: 103
      prefix: --threads
  - id: umeyama
    type:
      - 'null'
      - boolean
    doc: Use Umeyama algorithm for alignment
    inputBinding:
      position: 103
      prefix: --umeyama
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose output
    inputBinding:
      position: 103
      prefix: --verbose
outputs:
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory
    outputBinding:
      glob: $(inputs.outdir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/stringdecomposer:1.1.2--py311he264feb_5
