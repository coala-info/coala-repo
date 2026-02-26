cwlVersion: v1.2
class: CommandLineTool
baseCommand: blobtools seqfilter
label: blobtools_seqfilter
doc: "Filter sequences from a FASTA file based on a list of headers.\n\nTool homepage:
  https://blobtools.readme.io/docs/what-is-blobtools"
inputs:
  - id: infile
    type: File
    doc: FASTA file of sequences (Headers are split at whitespaces)
    inputBinding:
      position: 101
      prefix: --infile
  - id: invert
    type:
      - 'null'
      - boolean
    doc: Invert filtering (Sequences w/ headers NOT in list)
    inputBinding:
      position: 101
      prefix: --invert
  - id: list
    type: File
    doc: TXT file containing headers of sequences to keep
    inputBinding:
      position: 101
      prefix: --list
  - id: out_prefix
    type:
      - 'null'
      - string
    doc: Output prefix
    inputBinding:
      position: 101
      prefix: --out
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtools:1.1.1--py_1
stdout: blobtools_seqfilter.out
