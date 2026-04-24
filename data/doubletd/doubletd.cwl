cwlVersion: v1.2
class: CommandLineTool
baseCommand: doubletd
label: doubletd
doc: "Estimates the doublet rate from single-cell sequencing data.\n\nTool homepage:
  https://github.com/elkebir-group/doubletD"
inputs:
  - id: alpha_fn
    type:
      - 'null'
      - float
    doc: copy false negative error rate
    inputBinding:
      position: 101
      prefix: --alpha_fn
  - id: alpha_fp
    type:
      - 'null'
      - float
    doc: copy false positive error rate
    inputBinding:
      position: 101
      prefix: --alpha_fp
  - id: beta
    type:
      - 'null'
      - float
    doc: allelic dropout (ADO) rate
    inputBinding:
      position: 101
      prefix: --beta
  - id: binomial
    type:
      - 'null'
      - boolean
    doc: use binomial distribution for read count model
    inputBinding:
      position: 101
      prefix: --binomial
  - id: delta
    type:
      - 'null'
      - float
    doc: expected doublet rate
    inputBinding:
      position: 101
      prefix: --delta
  - id: input_alternate
    type:
      - 'null'
      - File
    doc: csv file with a table of alternate read counts for each position in 
      each cell
    inputBinding:
      position: 101
      prefix: --inputAlternate
  - id: input_total
    type:
      - 'null'
      - File
    doc: csv file with a table of total read counts for each position in each 
      cell
    inputBinding:
      position: 101
      prefix: --inputTotal
  - id: missing
    type:
      - 'null'
      - boolean
    doc: use missing data in the model?
    inputBinding:
      position: 101
      prefix: --missing
  - id: mu_hetero
    type:
      - 'null'
      - float
    doc: heterozygous mutation rate
    inputBinding:
      position: 101
      prefix: --mu_hetero
  - id: mu_hom
    type:
      - 'null'
      - float
    doc: homozygous mutation rate
    inputBinding:
      position: 101
      prefix: --mu_hom
  - id: noverbose
    type:
      - 'null'
      - boolean
    doc: do not output statements from internal solvers
    inputBinding:
      position: 101
      prefix: --noverbose
  - id: prec
    type:
      - 'null'
      - float
    doc: precision for beta-binomial distribution
    inputBinding:
      position: 101
      prefix: --prec
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file name
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/doubletd:0.1.0--py_0
