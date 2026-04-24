cwlVersion: v1.2
class: CommandLineTool
baseCommand: sketchy predict
label: sketchy_predict
doc: "Predict genotypes from reads or read streams\n\nTool homepage: https://github.com/esteinig/sketchy"
inputs:
  - id: consensus
    type:
      - 'null'
      - boolean
    doc: Consensus prediction over top feature values
    inputBinding:
      position: 101
      prefix: --consensus
  - id: genotypes
    type: File
    doc: Reference genotype table (.tsv)
    inputBinding:
      position: 101
      prefix: --genotypes
  - id: header
    type:
      - 'null'
      - boolean
    doc: Header added to output based on genotype file
    inputBinding:
      position: 101
      prefix: --header
  - id: input
    type:
      - 'null'
      - File
    doc: Fast{a,q}.{gz,xz,bz}, stdin if not present
    inputBinding:
      position: 101
      prefix: --input
  - id: limit
    type:
      - 'null'
      - int
    doc: Number of reads to process, all reads default
    inputBinding:
      position: 101
      prefix: --limit
  - id: reference
    type: File
    doc: Reference sketch, Mash (.msh) or Finch (.fsh)
    inputBinding:
      position: 101
      prefix: --reference
  - id: stream
    type:
      - 'null'
      - boolean
    doc: Sum of shared hashes per read output
    inputBinding:
      position: 101
      prefix: --stream
  - id: top
    type:
      - 'null'
      - int
    doc: Number of top ranked prediction to output
    inputBinding:
      position: 101
      prefix: --top
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sketchy:0.6.0--h7b50bb2_3
stdout: sketchy_predict.out
