cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - igdiscover
  - count
label: igdiscover_count
doc: "Compute expression counts: filter a table of IgBLAST results and count how often specific genes are named. The table is written to standard output.\n\nTool homepage: https://igdiscover.se/"
inputs:
  - id: table
    type: File
    doc: "Table with parsed and filtered IgBLAST results"
    inputBinding:
      position: 1
  - id: gene
    type: ['null', string]
    doc: "Which gene type: V, D or J. Default: V"
    inputBinding:
      position: 2
      prefix: --gene
  - id: database
    type: ['null', File]
    doc: "Compute expressions for the sequences that are named in the FASTA file (only names are used; also lists genes with zero expression)"
    inputBinding:
      position: 2
      prefix: --database
  - id: plot_path
    type: ['null', string]
    doc: "Plot expressions to FILE (PDF or PNG)"
    inputBinding:
      position: 2
      prefix: --plot
  - id: d_evalue
    type: ['null', double]
    doc: "Maximal allowed E-value for D gene match. Default: 1E-4 if gene is D, no restriction otherwise."
    inputBinding:
      position: 2
      prefix: --d-evalue
  - id: d_coverage
    type: ['null', double]
    doc: "Minimum D coverage (in percent). Default: 70 if gene is D, no restriction otherwise."
    inputBinding:
      position: 2
      prefix: --d-coverage
  - id: d_errors
    type: ['null', int]
    doc: "Maximum allowed D errors. Default: no limit."
    inputBinding:
      position: 2
      prefix: --d-errors
  - id: allele_ratio
    type: ['null', double]
    doc: "Required allele ratio. Works only for genes named NAME*ALLELE. Default: do not check allele ratio."
    inputBinding:
      position: 2
      prefix: --allele-ratio
outputs:
  - id: stdout
    type: stdout
    doc: "Expression count table"
  - id: plot
    type: ['null', File]
    doc: "Expression plot"
    outputBinding:
      glob: $(inputs.plot_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/igdiscover:0.15.1--pyhdfd78af_2
stdout: igdiscover_count.out
