cwlVersion: v1.2
class: CommandLineTool
baseCommand: KmerStreamEstimate.py
label: kmerstream_KmerStreamEstimate.py
doc: "Estimates genome size, error rate and coverage from the TSV output of KmerStream\n\nTool homepage: https://github.com/pmelsted/KmerStream"
inputs:
  - id: tsv_file
    type: File
    doc: "TSV file written by KmerStream --tsv"
    inputBinding:
      position: 1
outputs:
  - id: estimates
    type: stdout
    doc: "Table with the columns of the input plus F0-f1, G (genome size estimate), e (error rate) and lambda (coverage)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/kmerstream:1.1--h077b44d_6
stdout: kmerstream_estimate.tsv
