cwlVersion: v1.2
class: CommandLineTool
baseCommand: nanomonsv parse
label: nanomonsv_parse
doc: "Parse alignment files to identify structural variants.\n\nTool homepage: https://github.com/friend1ws/nanomonsv"
inputs:
  - id: alignment_file
    type: File
    doc: Path to input BAM or CRAM file
    inputBinding:
      position: 1
  - id: output_prefix
    type: string
    doc: Prefix of output files
    inputBinding:
      position: 2
  - id: debug
    type:
      - 'null'
      - boolean
    doc: keep intermediate files
    inputBinding:
      position: 103
      prefix: --debug
  - id: minimum_breakpoint_ambiguity
    type:
      - 'null'
      - int
    doc: Sizes of ambiguities of breakpoint positions from the observed ones
    inputBinding:
      position: 103
      prefix: --minimum_breakpoint_ambiguity
  - id: reference_fasta
    type:
      - 'null'
      - File
    doc: the path to the reference genome sequence
    inputBinding:
      position: 103
      prefix: --reference_fasta
  - id: split_alignment_check_margin
    type:
      - 'null'
      - int
    doc: Two split alignments whose margin sizes are no more than this value is 
      counted as candidate breakpoint
    inputBinding:
      position: 103
      prefix: --split_alignment_check_margin
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/nanomonsv:0.8.1--pyhdfd78af_0
stdout: nanomonsv_parse.out
