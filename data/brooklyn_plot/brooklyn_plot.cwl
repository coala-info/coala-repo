cwlVersion: v1.2
class: CommandLineTool
baseCommand: brooklyn_plot
label: brooklyn_plot
doc: "Gene co-expression and transcriptional bursting pattern recognition tool in
  single cell/nucleus RNA-sequencing data\n\nTool homepage: https://github.com/arunhpatil/brooklyn/"
inputs:
  - id: biomart
    type:
      - 'null'
      - File
    doc: the reference gene annotations (in .csv format)
    inputBinding:
      position: 101
      prefix: --biomart
  - id: corMethod
    type:
      - 'null'
      - string
    doc: 'the statistical approach for correlation measures (options: [pr, kt, bc]
      for pearsonr, kendalltau and bayesian correlation respectively. Default: pr)'
    inputBinding:
      position: 101
      prefix: --corMethod
  - id: h5ad
    type:
      - 'null'
      - File
    doc: input file in .h5ad format (accepts .h5ad)
    inputBinding:
      position: 101
      prefix: --h5ad
  - id: outDir
    type:
      - 'null'
      - Directory
    doc: the directory of the outputs
    inputBinding:
      position: 101
      prefix: --outDir
  - id: outFile
    type:
      - 'null'
      - string
    doc: the name of summarized brooklyn file as CSV file and a brooklyn plot in
      PDF
    inputBinding:
      position: 101
      prefix: --outFile
  - id: query
    type:
      - 'null'
      - File
    doc: the list of genes to be queried upon (one gene per line and in .csv 
      format)
    inputBinding:
      position: 101
      prefix: --query
  - id: subject
    type:
      - 'null'
      - File
    doc: the list of genes to be compared with (one gene per line and in .csv 
      format)
    inputBinding:
      position: 101
      prefix: --subject
  - id: threads
    type:
      - 'null'
      - int
    doc: the number of processors to use for trimming, qc, and alignment
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/brooklyn_plot:0.0.4--pyhdfd78af_0
stdout: brooklyn_plot.out
