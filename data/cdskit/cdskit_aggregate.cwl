cwlVersion: v1.2
class: CommandLineTool
baseCommand: cdskit_aggregate
label: cdskit_aggregate
doc: "Aggregate sequences based on a regular expression.\n\nTool homepage: https://github.com/kfuku52/cdskit"
inputs:
  - id: expression
    type:
      - 'null'
      - type: array
        items: string
    doc: A regular expression to aggregate the sequences. Multiple values can be
      specified.
    inputBinding:
      position: 101
      prefix: --expression
  - id: inseqformat
    type:
      - 'null'
      - string
    doc: "Input sequence format. See Biopython documentation for available options.\n\
      \                        https://biopython.org/wiki/SeqIO"
    inputBinding:
      position: 101
      prefix: --inseqformat
  - id: mode
    type:
      - 'null'
      - string
    doc: Criterion to keep a sequence during aggregation.
    inputBinding:
      position: 101
      prefix: --mode
  - id: outseqformat
    type:
      - 'null'
      - string
    doc: "Output sequence format. See Biopython documentation for available options.\n\
      \                        https://biopython.org/wiki/SeqIO"
    inputBinding:
      position: 101
      prefix: --outseqformat
  - id: seqfile
    type:
      - 'null'
      - File
    doc: Input sequence file. Use "-" for STDIN.
    inputBinding:
      position: 101
      prefix: --seqfile
outputs:
  - id: outfile
    type:
      - 'null'
      - File
    doc: Output sequence file. Use "-" for STDOUT.
    outputBinding:
      glob: $(inputs.outfile)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cdskit:0.16.1--pyhdfd78af_0
