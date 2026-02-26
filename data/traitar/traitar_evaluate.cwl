cwlVersion: v1.2
class: CommandLineTool
baseCommand: traitar_evaluate
label: traitar_evaluate
doc: "compare Traitar predictions against a given standard of truth\n\nTool homepage:
  http://github.com/aweimann/traitar"
inputs:
  - id: traitar_pred_f
    type: File
    doc: phenotype prediction matrix as return by Traitar
    inputBinding:
      position: 1
  - id: gold_standard_f
    type: File
    doc: phenotype matrix with standard of truth
    inputBinding:
      position: 2
  - id: are_pt_ids
    type:
      - 'null'
      - boolean
    doc: Set if the gold standard phenotype are indexed via phenotype IDs rather
      than accessions
    inputBinding:
      position: 103
      prefix: --are_pt_ids
  - id: min_samples
    type:
      - 'null'
      - int
    doc: minimum number of positive and negative samples to consider phenotypes 
      for calculation of the macro accuracy
    inputBinding:
      position: 103
      prefix: --min_samples
  - id: phenotype_archive
    type:
      - 'null'
      - File
    doc: Needed if gold standard uses an accession index for mapping
    inputBinding:
      position: 103
      prefix: --phenotype_archive
outputs:
  - id: out
    type: Directory
    doc: output directory
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/traitar:3.0.1--pyhdfd78af_0
