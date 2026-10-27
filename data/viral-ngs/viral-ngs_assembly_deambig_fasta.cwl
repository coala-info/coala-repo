cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - assembly.py
  - deambig_fasta
label: viral-ngs_assembly_deambig_fasta
doc: "Take input sequences (fasta) and replace any ambiguity bases with a random unambiguous base from among the possibilities described by the ambiguity code. Write output to fasta file.\n\nTool homepage: https://github.com/broadinstitute/viral-ngs"
inputs:
  - id: in_fasta
    type: File
    doc: "Input fasta file"
    inputBinding:
      position: 1
  - id: out_fasta
    type: string
    doc: "Output fasta file"
    inputBinding:
      position: 2
  - id: loglevel
    type:
      - 'null'
      - type: enum
        symbols:
          - DEBUG
          - INFO
          - WARNING
          - ERROR
          - CRITICAL
          - EXCEPTION
    doc: "Verboseness of output. [default: DEBUG]"
    inputBinding:
      position: 20
      prefix: --loglevel
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: out_fasta_file
    type: File
    doc: "Output fasta"
    outputBinding:
      glob: $(inputs.out_fasta)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/viral-ngs:1.13.4--py35_0
stdout: viral-ngs_assembly_deambig_fasta.out
