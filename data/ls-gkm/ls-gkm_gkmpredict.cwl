cwlVersion: v1.2
class: CommandLineTool
baseCommand: gkmpredict
label: ls-gkm_gkmpredict
doc: "Score test sequences using a gkm-SVM model trained with gkmtrain.\n\nTool homepage: https://github.com/Dongwon-Lee/lsgkm"
inputs:
  - id: test_seqfile
    type: File
    doc: Sequence file for test (FASTA format)
    inputBinding:
      position: 1
  - id: model_file
    type: File
    doc: Model file, output of gkmtrain
    inputBinding:
      position: 2
  - id: output_file
    type: string
    doc: Name of output file
    inputBinding:
      position: 3
  - id: verbosity
    type:
      - 'null'
      - int
    doc: 'Set the level of verbosity, 0 to 4 (default: 2)'
    inputBinding:
      position: 103
      prefix: -v
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Set the number of threads for parallel calculation: 1, 4, or 16 (default: 1)'
    inputBinding:
      position: 103
      prefix: -T
outputs:
  - id: predictions
    type: File
    doc: Scores of the test sequences
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ls-gkm:0.1.1--h9948957_0
