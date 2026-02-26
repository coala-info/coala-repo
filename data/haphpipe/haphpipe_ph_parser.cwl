cwlVersion: v1.2
class: CommandLineTool
baseCommand: haphpipe ph_parser
label: haphpipe_ph_parser
doc: "Parses the output of PredictHaplo to create a FASTA file of haplotypes.\n\n\
  Tool homepage: https://github.com/gwcbi/haphpipe"
inputs:
  - id: haplotypes_fa
    type: File
    doc: Haplotype file created by PredictHaplo.
    inputBinding:
      position: 101
      prefix: --haplotypes_fa
  - id: keep_gaps
    type:
      - 'null'
      - boolean
    doc: Do not remove gaps from alignment
    default: false
    inputBinding:
      position: 101
      prefix: --keep_gaps
  - id: logfile
    type:
      - 'null'
      - File
    doc: Append console output to this file
    inputBinding:
      position: 101
      prefix: --logfile
  - id: outdir
    type:
      - 'null'
      - Directory
    doc: Output directory.
    default: .
    inputBinding:
      position: 101
      prefix: --outdir
  - id: prefix
    type:
      - 'null'
      - string
    doc: Prefix to add to sequence names
    inputBinding:
      position: 101
      prefix: --prefix
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Do not write output to console (silence stdout and stderr)
    default: false
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/haphpipe:1.0.3--py_0
stdout: haphpipe_ph_parser.out
