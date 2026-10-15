cwlVersion: v1.2
class: CommandLineTool
baseCommand: [/usr/local/bin/share/physlr-1.0.4-0/src/physlr-filter-barcodes]
label: physlr_filter-barcodes
doc: "Filter barcodes by the number of minimizers they have: keep barcodes with between n and N minimizers.\n\nTool homepage: https://github.com/BirolLab/physlr"
inputs:
  - id: min_minimizers
    type: int
    doc: "minimum number of minimizers per barcode"
    inputBinding:
      position: 1
      prefix: -n
  - id: max_minimizers
    type: int
    doc: "maximum number of minimizers per barcode"
    inputBinding:
      position: 2
      prefix: -N
  - id: silent
    type: ['null', string]
    doc: "silent; disable verbose output. This build reads a value after -s (for example 1) and ignores it"
    inputBinding:
      position: 3
      prefix: -s
  - id: output_name
    type: ['null', string]
    doc: "write the output to this file name"
    default: physlr_filter-barcodes.tsv
    inputBinding:
      position: 4
      prefix: -o
  - id: minimizer_files
    type: File[]
    doc: "Minimizer TSV files as written by physlr-indexlr (barcode, a tab, minimizers). The help text says FASTQ, but the tool reads these tables"
    inputBinding:
      position: 100
outputs:
  - id: result
    type: File
    doc: "Minimizer TSV file of the retained barcodes"
    outputBinding:
      glob: $(inputs.output_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/physlr:1.0.4--py39h2df963e_0
