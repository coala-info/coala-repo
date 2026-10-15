cwlVersion: v1.2
class: CommandLineTool
baseCommand: [phyluce_align_get_incomplete_matrix_estimates]
label: phyluce_phyluce_align_get_incomplete_matrix_estimates
doc: "Query a probes.matches.sqlite db for matrix completeness.\n\nTool homepage: https://github.com/faircloth-lab/phyluce"
inputs:
  - id: db
    type: File
    doc: "The probe.matches.sqlite database to query."
    inputBinding:
      position: 1
      prefix: --db
  - id: min
    type: ['null', float]
    doc: "The minimum of the range to evaluate (0 <= value < 1)."
    inputBinding:
      position: 2
      prefix: --min
  - id: max
    type: ['null', float]
    doc: "The maximum of the range to evaluate (0 <= value <= 1)."
    inputBinding:
      position: 3
      prefix: --max
  - id: step
    type: ['null', float]
    doc: "The step of the range to evaluate (0 <= value <= 1)."
    inputBinding:
      position: 4
      prefix: --step
  - id: exclude
    type:
      - 'null'
      - type: array
        items: string
    doc: "Taxa to exclude (cannot be used with --include)."
    inputBinding:
      position: 5
      prefix: --exclude
  - id: include
    type:
      - 'null'
      - type: array
        items: string
    doc: "Taxa to include (cannot be used with --exclude)."
    inputBinding:
      position: 6
      prefix: --include
outputs:
  - id: estimates
    type: stdout
    doc: "CSV-style table of taxon frequency cut points and the number of loci."
stdout: phyluce_align_get_incomplete_matrix_estimates.stdout.txt
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/phyluce:1.6.8--py_0
