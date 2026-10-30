cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-map-query.R
label: seurat-scripts_seurat-map-query.R
doc: 'Map query cells onto a reference with anchors (Seurat MapQuery).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: query_object_file
    type: File
    doc: Query file with Seurat object in either RDS-Seurat, Loom or SCE
    inputBinding:
      position: 1
      prefix: --query-object-file=
      separate: false
  - id: anchors_object_file
    type: File
    doc: Input file with Seurat object with anchors in either RDS-Seurat, Loom or SCE
    inputBinding:
      position: 2
      prefix: --anchors-object-file=
      separate: false
  - id: refdata_field_or_assay
    type: string
    doc: The name of the metadata field or assay from the reference object provided. This requires the reference parameter to be specified.
    inputBinding:
      position: 3
      prefix: --refdata-field-or-assay=
      separate: false
  - id: output_object_file
    type: string
    doc: FILE IN
    inputBinding:
      position: 4
      prefix: --output-object-file=
      separate: false
  - id: query_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the input format to read.
    inputBinding:
      position: 5
      prefix: --query-format=
      separate: false
  - id: anchors_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the anchors format to read.
    inputBinding:
      position: 6
      prefix: --anchors-format=
      separate: false
  - id: reference_object_file
    type: File
    doc: Input file with Seurat object with reference (and UMAP) in either RDS-Seurat, Loom or SCE (not marked mandatory by the script, but it stops without it)
    inputBinding:
      position: 7
      prefix: --reference-object-file=
      separate: false
  - id: reference_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the reference format to read.
    inputBinding:
      position: 8
      prefix: --reference-format=
      separate: false
  - id: new_reduction_name
    type:
      - 'null'
      - string
    doc: Name for new integrated dimensional reduction.
    inputBinding:
      position: 9
      prefix: --new-reduction-name=
      separate: false
  - id: reference_reduction
    type:
      - 'null'
      - string
    doc: Name of reduction to use from the reference for neighbor finding
    inputBinding:
      position: 10
      prefix: --reference-reduction=
      separate: false
  - id: reduction_model
    type:
      - 'null'
      - string
    doc: DimReduc object name that contains the umap model
    inputBinding:
      position: 11
      prefix: --reduction-model=
      separate: false
  - id: transferdata_args
    type:
      - 'null'
      - string
    doc: A named list of additional arguments to TransferData, written in R syntax .ie list( argument = 'value' )
    inputBinding:
      position: 12
      prefix: --transferdata-args=
      separate: false
  - id: integrated_embedding_args
    type:
      - 'null'
      - string
    doc: A named list of additional arguments to IntegrateEmbeddings, written in R syntax .ie list( argument = 'value' )
    inputBinding:
      position: 13
      prefix: --integrated-embedding-args=
      separate: false
  - id: project_umap_args
    type:
      - 'null'
      - string
    doc: A named list of additional arguments to ProjectUMAP, written in R syntax .ie list( argument = 'value' )
    inputBinding:
      position: 14
      prefix: --project-umap-args=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the anchors format to read.'
    inputBinding:
      position: 15
      prefix: --output-format=
      separate: false
outputs:
  - id: output_object_file
    type: File
    doc: FILE IN
    outputBinding:
      glob: $(inputs.output_object_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
