cwlVersion: v1.2
class: CommandLineTool
baseCommand: qimba_derep
label: qimba_derep
doc: "Dereplicate FASTA sequences using USEARCH.\n\n  This command identifies and
  collapses identical sequences, keeping track\n  of their abundance in the sequence
  headers.\n\nTool homepage: https://github.com/quadram-institute-bioscience/qimba"
inputs:
  - id: input_fasta
    type: File
    doc: Input FASTA file to dereplicate
    inputBinding:
      position: 101
      prefix: --input-fasta
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads
    default: '4'
    inputBinding:
      position: 101
      prefix: --threads
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: output
    type: File
    doc: Output FASTA file with unique sequences
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/qimba:0.4.0--pyhdfd78af_0
