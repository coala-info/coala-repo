cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-convert.R
label: seurat-scripts_seurat-convert.R
doc: 'Convert a Seurat object between formats (Seurat, h5seurat, Loom, SingleCellExperiment, AnnData).


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object_file
    type: File
    doc: Input file with Seurat object in either RDS-Seurat, Loom or SCE
    inputBinding:
      position: 1
      prefix: --input-object-file=
      separate: false
  - id: output_object_file
    type: string
    doc: Path to the output file, when using Loom as output, the final file will contain .loom at the end of the given file name.
    inputBinding:
      position: 2
      prefix: --output-object-file=
      separate: false
  - id: input_format
    type:
      - 'null'
      - string
    doc: Either loom, seurat, h5seurat, anndata or singlecellexperiment for the input format to read.
    inputBinding:
      position: 3
      prefix: --input-format=
      separate: false
  - id: output_format
    type:
      - 'null'
      - string
    doc: Either seurat, h5seurat, loom, singlecellexperiment or h5seurat (partial support)
    inputBinding:
      position: 4
      prefix: --output-format=
      separate: false
  - id: input_assay
    type:
      - 'null'
      - string
    doc: The assay to be read from the input object, if it corresponds
    inputBinding:
      position: 5
      prefix: --input-assay=
      separate: false
outputs:
  - id: output_object_file
    type: File
    doc: Path to the output file, when using Loom as output, the final file will contain .loom at the end of the given file name.
    outputBinding:
      glob: $(inputs.output_object_file)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
