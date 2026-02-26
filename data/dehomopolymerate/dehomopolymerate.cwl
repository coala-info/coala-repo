cwlVersion: v1.2
class: CommandLineTool
baseCommand: dehomopolymerate
label: dehomopolymerate
doc: "Collapse sequence homopolymers to a single character\n\nTool homepage: https://github.com/tseemann/dehomopolymerate"
inputs:
  - id: input_reads
    type: File
    doc: Input FASTQ file (can be gzipped)
    inputBinding:
      position: 1
  - id: min_length
    type:
      - 'null'
      - int
    doc: Discard output sequences shorter then L bp
    inputBinding:
      position: 102
      prefix: -l
  - id: output_fasta
    type:
      - 'null'
      - boolean
    doc: Output FASTA not FASTQ
    inputBinding:
      position: 102
      prefix: -f
  - id: output_raw
    type:
      - 'null'
      - boolean
    doc: Output RAW one line per sequence
    inputBinding:
      position: 102
      prefix: -w
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode; not non-error output
    inputBinding:
      position: 102
      prefix: -q
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dehomopolymerate:0.4.1--h577a1d6_0
stdout: dehomopolymerate.out
