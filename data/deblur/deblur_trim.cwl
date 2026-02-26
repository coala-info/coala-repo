cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deblur
  - trim
label: deblur_trim
doc: "Trim FASTA sequences\n\nTool homepage: https://github.com/biocore/deblur"
inputs:
  - id: seqs_fp
    type: File
    doc: Input FASTA file
    inputBinding:
      position: 1
  - id: log_file
    type:
      - 'null'
      - File
    doc: log file name
    default: deblur.log
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - int
    doc: Level of messages for log file (range 1-debug to 5-critical)
    default: 2
    inputBinding:
      position: 102
      prefix: --log-level
  - id: trim_length
    type: int
    doc: Sequence trim length
    inputBinding:
      position: 102
      prefix: --trim-length
outputs:
  - id: output_fp
    type: File
    doc: Output FASTA file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
