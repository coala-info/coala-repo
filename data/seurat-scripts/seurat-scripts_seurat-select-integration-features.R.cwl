cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-select-integration-features.R
label: seurat-scripts_seurat-select-integration-features.R
doc: 'Select features that are variable across several Seurat objects (Seurat SelectIntegrationFeatures).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object_files
    type:
      type: array
      items: File
    doc: A list of Seurat objects between which to find anchors for downstream integration. Input files in either RDS-Seurat, Loom or SCE, comma separated.
    inputBinding:
      position: 1
      prefix: --input-object-files=
      separate: false
      itemSeparator: ','
  - id: file_out
    type: string
    doc: FILE IN
    inputBinding:
      position: 2
      prefix: --file-out=
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the input format to read.
    inputBinding:
      position: 3
      prefix: --input-format=
      separate: false
  - id: nfeatures
    type:
      - 'null'
      - int
    doc: Number of features to return
    inputBinding:
      position: 4
      prefix: --nfeatures=
      separate: false
  - id: assay_list
    type:
      - 'null'
      - string
    doc: Name or vector of assay names (one for each object) from which to pull the variable features.
    inputBinding:
      position: 5
      prefix: --assay-list=
      separate: false
  - id: do_not_verbose
    type:
      - 'null'
      - boolean
    doc: Print messages
    inputBinding:
      position: 6
      prefix: --do-not-verbose
  - id: fvf_nfeatures
    type:
      - 'null'
      - int
    doc: nfeatures for FindVariableFeatures. Used if VariableFeatures have not been set for any object in input.
    inputBinding:
      position: 7
      prefix: --fvf-nfeatures=
      separate: false
outputs:
  - id: file_out
    type: File
    doc: FILE IN
    outputBinding:
      glob: $(inputs.file_out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
