cwlVersion: v1.2
class: CommandLineTool
baseCommand: genePredFilter
label: ucsc-genepredfilter
doc: "Filter a genePred file, dropping invalid entries.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: gene_pred_in
    type: File
    doc: Input genePred file
    inputBinding:
      position: 1
  - id: gene_pred_out_name
    type: string
    doc: Name of the output filtered genePred file
    inputBinding:
      position: 2
  - id: db
    type:
      - 'null'
      - string
    doc: If specified, this database is used to get chromosome sizes
    inputBinding:
      position: 101
      prefix: -db=
      separate: false
  - id: chrom_sizes
    type:
      - 'null'
      - File
    doc: Use chrom sizes from this tab separated file (name, size) instead of from the chromInfo table in the specified db
    inputBinding:
      position: 101
      prefix: -chromSizes=
      separate: false
  - id: verbose
    type:
      - 'null'
      - int
    doc: Level >= 2 prints out errors for each problem found
    inputBinding:
      position: 101
      prefix: -verbose=
      separate: false
outputs:
  - id: gene_pred_out
    type: File
    doc: Output filtered genePred file
    outputBinding:
      glob: $(inputs.gene_pred_out_name)
  - id: messages
    type: stderr
    doc: Messages about dropped entries
stderr: ucsc-genepredfilter.err
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-genepredfilter:482--h0b57e2e_0
