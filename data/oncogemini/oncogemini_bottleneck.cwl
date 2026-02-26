cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncogemini bottleneck
label: oncogemini_bottleneck
doc: "Analyze bottleneck in cancer evolution\n\nTool homepage: https://github.com/fakedrtom/oncogemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried
    inputBinding:
      position: 1
  - id: cancers
    type:
      - 'null'
      - string
    doc: Restrict results to variants/genes associated with specific cancer 
      types by entering a comma-separated string of cancer type abbreviations 
      (see documents for abbreviations) REQUIRES that db include 
      civic_gene_abbrevations and/or cgi_gene_abbreviations
    inputBinding:
      position: 102
      prefix: --cancers
  - id: columns
    type:
      - 'null'
      - string
    doc: A list of columns that you would like returned
    default: '*'
    inputBinding:
      position: 102
      prefix: --columns
  - id: end_diff
    type:
      - 'null'
      - float
    doc: Minimum required AF difference between the samples representing the 
      first and final timepoints
    default: 0
    inputBinding:
      position: 102
      prefix: --endDiff
  - id: filter
    type:
      - 'null'
      - string
    doc: Restrictions to apply to variants (SQL syntax)
    inputBinding:
      position: 102
      prefix: --filter
  - id: max_norm
    type:
      - 'null'
      - float
    doc: Specify a maximum normal sample AF to allow
    default: 0
    inputBinding:
      position: 102
      prefix: --maxNorm
  - id: min_dp
    type:
      - 'null'
      - int
    doc: Minimum depth required in all samples
    default: 0
    inputBinding:
      position: 102
      prefix: --minDP
  - id: min_end
    type:
      - 'null'
      - float
    doc: Minimum AF required of the sample representing the final timepoint
    default: 0
    inputBinding:
      position: 102
      prefix: --minEnd
  - id: min_gq
    type:
      - 'null'
      - int
    doc: Minimum genotype quality required in all samples
    default: 0
    inputBinding:
      position: 102
      prefix: --minGQ
  - id: min_r
    type:
      - 'null'
      - float
    doc: Minimum r correlation coefficient required for AFs
    default: 0.5
    inputBinding:
      position: 102
      prefix: --minR
  - id: min_slope
    type:
      - 'null'
      - float
    doc: Minimum slope required for the AFs across samples
    default: 0.05
    inputBinding:
      position: 102
      prefix: --minSlope
  - id: patient
    type:
      - 'null'
      - string
    doc: Specify a patient to filter (should correspond to a patient_id in ped 
      file)
    inputBinding:
      position: 102
      prefix: --patient
  - id: purity
    type:
      - 'null'
      - boolean
    doc: Using purity estimates in sample manifest file, make corrections to AF 
      to be used
    inputBinding:
      position: 102
      prefix: --purity
  - id: samples
    type:
      - 'null'
      - string
    doc: Rather than including all samples, a string of comma-separated 
      specified samples to use
    default: All
    inputBinding:
      position: 102
      prefix: --samples
  - id: somatic_only
    type:
      - 'null'
      - boolean
    doc: Only include variants that have been marked as somatic via the 
      set_somatic command
    inputBinding:
      position: 102
      prefix: --somatic_only
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
stdout: oncogemini_bottleneck.out
