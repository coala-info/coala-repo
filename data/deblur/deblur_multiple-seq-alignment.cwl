cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deblur
  - multiple-seq-alignment
label: deblur_multiple-seq-alignment
doc: "Multiple sequence alignment\n\nTool homepage: https://github.com/biocore/deblur"
inputs:
  - id: seqs_fp
    type: File
    doc: Input sequence file
    inputBinding:
      position: 1
  - id: log_file
    type:
      - 'null'
      - File
    doc: log file name
    inputBinding:
      position: 102
      prefix: --log-file
  - id: log_level
    type:
      - 'null'
      - int
    doc: Level of messages for log file (range 1-debug to 5-critical)
    inputBinding:
      position: 102
      prefix: --log-level
  - id: threads_per_sample
    type:
      - 'null'
      - int
    doc: Number of threads to use per sample (0 to use all)
    inputBinding:
      position: 102
      prefix: --threads-per-sample
outputs:
  - id: output_fp
    type: File
    doc: Output file path
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
