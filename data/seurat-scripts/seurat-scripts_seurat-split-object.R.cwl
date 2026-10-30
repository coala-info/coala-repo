cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-split-object.R
label: seurat-scripts_seurat-split-object.R
doc: 'Split a Seurat object into several objects by a metadata field (Seurat SplitObject).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object
    type: File
    doc: RDS/Loom/SCE serialised object with content to split.
    inputBinding:
      position: 1
      prefix: --input-object=
      separate: false
  - id: split_by
    type: string
    doc: Field to split data by. Required.
    inputBinding:
      position: 2
      prefix: --split-by=
      separate: false
  - id: metadata_rds
    type:
      - 'null'
      - File
    doc: Optional RDS with metadata.
    inputBinding:
      position: 3
      prefix: --metadata-rds=
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the input format to read.
    inputBinding:
      position: 4
      prefix: --input-format=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, anndata or singlecellexperiment for the output format.
    inputBinding:
      position: 5
      prefix: --output-format=
      separate: false
  - id: output_path
    type: string
    default: split_out
    doc: Output path, where split files will be left (the directory is created before the run)
    inputBinding:
      position: 6
      prefix: --output-path=
      separate: false
outputs:
  - id: split_objects
    type:
      type: array
      items: File
    doc: Split objects, one file per value of the split field
    outputBinding:
      glob: $(inputs.output_path)/*
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_path)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
