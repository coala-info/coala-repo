cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fast_convert
label: pomoxis_fast_convert
doc: "Convert between fasta and fastq. Reads standard input and writes standard output.\n\nTool homepage: https://github.com/nanoporetech/pomoxis"
inputs:
  - id: conversion
    type: string
    doc: 'Conversion code from->to: qq, aa, aq or qa (a = fasta, q = fastq).'
    inputBinding:
      position: 1
  - id: reads
    type: File
    doc: Input fasta or fastq file (read from standard input).
  - id: discard_q
    type:
      - 'null'
      - boolean
    doc: Discard quality information from fastq, use with --mock_q.
    inputBinding:
      position: 102
      prefix: --discard_q
  - id: mock_q
    type:
      - 'null'
      - int
    doc: Mock quality value, valid for aq and qq (default 10).
    inputBinding:
      position: 102
      prefix: --mock_q
outputs:
  - id: converted
    type: stdout
    doc: Converted sequences.
stdin: $(inputs.reads.path)
stdout: fast_convert_out.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pomoxis:0.3.16--pyhdfd78af_0
