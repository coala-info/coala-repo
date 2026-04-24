cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - deblur
  - deblur-seqs
label: deblur_deblur-seqs
doc: "Clean read errors from Illumina reads\n\nTool homepage: https://github.com/biocore/deblur"
inputs:
  - id: seqs_fp
    type: File
    doc: SEQS_FP
    inputBinding:
      position: 1
  - id: error_dist
    type:
      - 'null'
      - string
    doc: A comma separated list of error probabilities for each hamming 
      distance. The length of the list determines the number of hamming 
      distances taken into account.
      0.001, 0.0005
    inputBinding:
      position: 102
      prefix: --error-dist
  - id: indel_max
    type:
      - 'null'
      - int
    doc: Maximal indel number
    inputBinding:
      position: 102
      prefix: --indel-max
  - id: indel_prob
    type:
      - 'null'
      - float
    doc: Insertion/deletion (indel) probability (same for N indels)
    inputBinding:
      position: 102
      prefix: --indel-prob
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
    doc: Level of messages for log file (range 1-debug to 5-critical
    inputBinding:
      position: 102
      prefix: --log-level
  - id: mean_error
    type:
      - 'null'
      - float
    doc: The mean per nucleotide error, used for original sequence estimate. If 
      not passed typical illumina error rate is used
    inputBinding:
      position: 102
      prefix: --mean-error
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/deblur:1.1.1--pyhdfd78af_0
stdout: deblur_deblur-seqs.out
