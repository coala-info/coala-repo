cwlVersion: v1.2
class: CommandLineTool
baseCommand: gkmpredict
label: ls-gkm_gkmpredict
doc: "Predict functional genomic elements using gapped k-mer SVM (ls-gkm).\n\nTool
  homepage: https://github.com/Dongwon-Lee/lsgkm"
inputs:
  - id: test_seq_file
    type: File
    doc: Sequence file for testing (fasta format)
    inputBinding:
      position: 1
  - id: model_file
    type: File
    doc: Model file
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: Set number of threads
    default: 1
    inputBinding:
      position: 103
      prefix: -t
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Set verbosity level (0-4)
    default: 2
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: output_file
    type: File
    doc: Output file name
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ls-gkm:0.1.1--h9948957_0
