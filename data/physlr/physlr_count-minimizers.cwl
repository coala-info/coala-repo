cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/bin/physlr, count-minimizers]
label: physlr_count-minimizers
doc: "Count the frequency of each minimizer (the number of barcodes it occurs in) and print the depths.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: minimizer_files
    type: File[]
    doc: "Minimizers in TSV format: barcode, a tab, then space-separated minimizers (as written by physlr-indexlr)"
    inputBinding:
      position: 100
  - id: min_count
    type: ['null', int]
    doc: "ignore minimizers that occur in less than this many barcodes [2]"
    inputBinding:
      position: 1
      prefix: -c
  - id: verbose
    type: ['null', int]
    doc: "the level of verbosity: 0 silent, 1 periodic, 2 progress, 3 verbose [2]"
    inputBinding:
      position: 2
      prefix: -V
outputs:
  - id: result
    type: File
    doc: "Depth of each minimizer that occurs in at least min_count barcodes (header Depth)"
    outputBinding:
      glob: physlr_count-minimizers.tsv
stdout: physlr_count-minimizers.tsv
requirements:
  - class: EnvVarRequirement
    envDef:
      - envName: PYTHONPATH
        envValue: /usr/local/bin/share/physlr-1.0.4-0
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
