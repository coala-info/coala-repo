cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pvacseq
  - binding_filter
label: pvacseq_binding_filter
doc: "Filter pVACseq final report epitopes based on binding affinity and fold change.\n\
  \nTool homepage: https://github.com/griffithlab/pVAC-Seq"
inputs:
  - id: input_file
    type: File
    doc: The final report .tsv file to filter
    inputBinding:
      position: 1
  - id: binding_threshold
    type:
      - 'null'
      - int
    doc: Report only epitopes where the mutant allele has ic50 binding scores 
      below this value.
    inputBinding:
      position: 102
      prefix: --binding-threshold
  - id: minimum_fold_change
    type:
      - 'null'
      - float
    doc: Minimum fold change between mutant binding score and wild-type score. 
      The default is 0, which filters no results, but 1 is often a sensible 
      option (requiring that binding is better to the MT than WT).
    inputBinding:
      position: 102
      prefix: --minimum-fold-change
  - id: top_score_metric
    type:
      - 'null'
      - string
    doc: 'The ic50 scoring metric to use when filtering epitopes by binding-threshold
      or minimum fold change. lowest: Best MT Score/Corresponding Fold Change; median:
      Median MT Score/Median Fold Change.'
    inputBinding:
      position: 102
      prefix: --top-score-metric
outputs:
  - id: output_file
    type: File
    doc: Output .tsv file containing list of filtered epitopes based on binding 
      affinity
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pvacseq:4.0.10--py36_0
