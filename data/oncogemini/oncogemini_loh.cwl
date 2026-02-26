cwlVersion: v1.2
class: CommandLineTool
baseCommand: oncogemini loh
label: oncogemini_loh
doc: "Filter and query LOH variants from a database.\n\nTool homepage: https://github.com/fakedrtom/oncogemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried.
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
    doc: A comma-separated list of columns that you would like returned
    default: '*'
    inputBinding:
      position: 102
      prefix: --columns
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
    default: 0.7
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
  - id: min_gq
    type:
      - 'null'
      - int
    doc: Minimum genotype quality required in all samples
    default: 0
    inputBinding:
      position: 102
      prefix: --minGQ
  - id: min_norm
    type:
      - 'null'
      - float
    doc: Specify a minimum normal sample AF to allow
    default: 0.3
    inputBinding:
      position: 102
      prefix: --minNorm
  - id: min_tumor
    type:
      - 'null'
      - float
    doc: Specify a minimum AF for tumor samples to require
    default: 0.8
    inputBinding:
      position: 102
      prefix: --minTumor
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
    doc: Rather than including all samples, enter a string of comma-separated 
      specified samples to use
    default: All
    inputBinding:
      position: 102
      prefix: --samples
  - id: specific
    type:
      - 'null'
      - string
    doc: Search for LOH variants in a single sample compared to the sample(s) 
      that precede it (must specify single sample included among --samples, also
      --minNorm, --maxNorm will now apply to the preceding sample)
    inputBinding:
      position: 102
      prefix: --specific
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/oncogemini:1.0.0--pyh3252c3a_0
stdout: oncogemini_loh.out
