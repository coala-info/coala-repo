cwlVersion: v1.2
class: CommandLineTool
baseCommand: fraposa_pred
label: fraposa-pgsc_fraposa_pred
doc: "Predicts the genetic risk score for a study population based on a reference
  population.\n\nTool homepage: https://github.com/PGScatalog/fraposa_pgsc"
inputs:
  - id: ref_filepref
    type: string
    doc: Prefix of binary PLINK file for the reference data.
    inputBinding:
      position: 1
  - id: stu_filepref
    type: string
    doc: Prefix of binary PLINK file for the study data.
    inputBinding:
      position: 2
  - id: nneighbors
    type:
      - 'null'
      - int
    doc: The number of neighbors for each study sample.
    default: 20
    inputBinding:
      position: 103
      prefix: --nneighbors
  - id: weights
    type:
      - 'null'
      - string
    doc: 'The method for calculating the weights in the nearest neighbor method. uniform:
      each neighbor receives the same weight; distance: the weight of each neighbor
      is inversely proportional to its distance from the study sample.'
    default: uniform
    inputBinding:
      position: 103
      prefix: --weights
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fraposa-pgsc:1.0.2--pyhdfd78af_0
stdout: fraposa-pgsc_fraposa_pred.out
