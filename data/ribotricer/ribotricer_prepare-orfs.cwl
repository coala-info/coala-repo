cwlVersion: v1.2
class: CommandLineTool
baseCommand: ribotricer prepare-orfs
label: ribotricer_prepare-orfs
doc: "Extract candidate ORFS based on GTF and FASTA files\n\nTool homepage: https://github.com/smithlabcode/ribotricer"
inputs:
  - id: fasta
    type: File
    doc: Path to FASTA file
    inputBinding:
      position: 101
      prefix: --fasta
  - id: gtf
    type: File
    doc: Path to GTF file
    inputBinding:
      position: 101
      prefix: --gtf
  - id: longest
    type:
      - 'null'
      - boolean
    doc: Choose the most upstream start codon if multiple in frame ones exist
    inputBinding:
      position: 101
      prefix: --longest
  - id: min_orf_length
    type:
      - 'null'
      - int
    doc: The minimum length (nts) of ORF to include
    inputBinding:
      position: 101
      prefix: --min_orf_length
  - id: prefix
    type: string
    doc: Prefix to output file
    inputBinding:
      position: 101
      prefix: --prefix
  - id: start_codons
    type:
      - 'null'
      - string
    doc: Comma separated list of start codons
    inputBinding:
      position: 101
      prefix: --start_codons
  - id: stop_codons
    type:
      - 'null'
      - string
    doc: Comma separated list of stop codons
    inputBinding:
      position: 101
      prefix: --stop_codons
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ribotricer:1.5.0--pyhdfd78af_0
stdout: ribotricer_prepare-orfs.out
