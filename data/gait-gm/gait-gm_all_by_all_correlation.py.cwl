cwlVersion: v1.2
class: CommandLineTool
baseCommand: all_by_all_correlation.py
label: gait-gm_all_by_all_correlation.py
doc: "allByAllCorr: all-by-all correlation between a gene expression dataset and a metabolomic dataset.

Tool homepage: https://github.com/secimTools/gait-gm"
inputs:
  - id: gene_dataset
    type: File
    doc: "Gene Expression dataset."
    inputBinding:
      position: 101
      prefix: --geneDataset
  - id: gene_id
    type: string
    doc: "Gene Unique ID column name."
    inputBinding:
      position: 101
      prefix: --geneId
  - id: gene_annot
    type:
      - 'null'
      - File
    doc: "Gene Expression Annotation Dataset."
    inputBinding:
      position: 101
      prefix: --geneAnnot
  - id: gene_name
    type:
      - 'null'
      - string
    doc: "Gene Expression Annotation Dataset column."
    inputBinding:
      position: 101
      prefix: --geneName
  - id: met_dataset
    type: File
    doc: "Metabolomic Datset."
    inputBinding:
      position: 101
      prefix: --metDataset
  - id: met_id
    type: string
    doc: "Metabolite Unique ID column name."
    inputBinding:
      position: 101
      prefix: --metId
  - id: met_annot
    type:
      - 'null'
      - File
    doc: "Metabolomic Annotation Dataset."
    inputBinding:
      position: 101
      prefix: --metAnnot
  - id: met_name
    type:
      - 'null'
      - string
    doc: "Metabolomics Annotation Dataset column."
    inputBinding:
      position: 101
      prefix: --metName
  - id: meth
    type: string
    doc: "Correlation coefficient to be computed."
    inputBinding:
      position: 101
      prefix: --meth
  - id: thres
    type: float
    doc: "Pvalue threshold for the output."
    inputBinding:
      position: 101
      prefix: --thres
  - id: output_path
    type: string
    doc: "Output Table."
    inputBinding:
      position: 101
      prefix: --output
  - id: cor_mat_path
    type: string
    doc: "Correlation Matrix."
    inputBinding:
      position: 101
      prefix: --corMat
  - id: fig_path
    type: string
    doc: "Output figure name for results [pdf]."
    inputBinding:
      position: 101
      prefix: --fig
outputs:
  - id: output
    type: File
    doc: "Output Table"
    outputBinding:
      glob: $(inputs.output_path)
  - id: cor_mat
    type: File
    doc: "Correlation Matrix"
    outputBinding:
      glob: $(inputs.cor_mat_path)
  - id: fig
    type: File
    doc: "Output figure (pdf)"
    outputBinding:
      glob: $(inputs.fig_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gait-gm:21.7.22--pyhdfd78af_0
