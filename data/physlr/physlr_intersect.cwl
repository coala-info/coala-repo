cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, intersect]
label: physlr_intersect
doc: "Print the minimizers in the intersection of each pair of barcodes.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: minimizer_files
    type: File[]
    doc: "Minimizers in TSV format: barcode, a tab, then space-separated minimizers (as written by physlr-indexlr)"
    inputBinding:
      position: 100
  - id: min_shared_minimizers
    type: ['null', int]
    doc: "remove edges with fewer than this many shared minimizers [0]"
    inputBinding:
      position: 1
      prefix: -m
  - id: vertices
    type: ['null', string]
    doc: "comma-separated list of vertices"
    inputBinding:
      position: 2
      prefix: -v
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 3
      prefix: -V
outputs:
  - id: result
    type: File
    doc: "One line per barcode pair: barcode 1, barcode 2, then the shared minimizers"
    outputBinding:
      glob: physlr_intersect.tsv
stdout: physlr_intersect.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
