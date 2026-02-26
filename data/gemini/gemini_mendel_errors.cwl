cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gemini
  - mendel_errors
label: gemini_mendel_errors
doc: "Identify mendelian errors in a family structure.\n\nTool homepage: https://github.com/arq5x/gemini"
inputs:
  - id: db
    type: string
    doc: The name of the database to be queried.
    inputBinding:
      position: 1
  - id: columns
    type:
      - 'null'
      - string
    doc: A list of columns that you would like returned.
    default: '*'
    inputBinding:
      position: 102
      prefix: --columns
  - id: families
    type:
      - 'null'
      - string
    doc: Restrict analysis to a specific set of 1 or more (comma) separated) 
      families
    inputBinding:
      position: 102
      prefix: --families
  - id: filter
    type:
      - 'null'
      - string
    doc: Restrictions to apply to variants (SQL syntax)
    inputBinding:
      position: 102
      prefix: --filter
  - id: gt_pl_max
    type:
      - 'null'
      - float
    doc: The maximum phred-scaled genotype likelihod (PL) allowed for each 
      sample in a family.
    inputBinding:
      position: 102
      prefix: --gt-pl-max
  - id: lenient
    type:
      - 'null'
      - boolean
    doc: Loosen the restrictions on family structure
    inputBinding:
      position: 102
      prefix: --lenient
  - id: min_gq
    type:
      - 'null'
      - int
    doc: The minimum genotype quality required for each sample in a family
    default: 0
    inputBinding:
      position: 102
      prefix: --min-gq
  - id: min_kindreds
    type:
      - 'null'
      - int
    doc: The min. number of kindreds that must have a candidate variant in a 
      gene.
    inputBinding:
      position: 102
      prefix: --min-kindreds
  - id: min_sample_depth
    type:
      - 'null'
      - int
    doc: The minimum aligned sequence depth required for each sample in a family
    default: 0
    inputBinding:
      position: 102
      prefix: -d
  - id: only_affected
    type:
      - 'null'
      - boolean
    doc: only consider candidates from affected samples.
    inputBinding:
      position: 102
      prefix: --only-affected
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gemini:0.30.2--py27hacb5245_0
stdout: gemini_mendel_errors.out
