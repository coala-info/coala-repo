cwlVersion: v1.2
class: CommandLineTool
baseCommand: seurat-export-cellbrowser.R
label: seurat-scripts_seurat-export-cellbrowser.R
doc: 'Export a Seurat object to a UCSC Cell Browser directory.


  Tool homepage: https://github.com/ebi-gene-expression-group/r-seurat-scripts'
inputs:
  - id: input_object_file
    type: File
    doc: File name in which a serialized R matrix object may be found.
    inputBinding:
      position: 1
      prefix: --input-object-file=
      separate: false
  - id: output_directory
    type: string
    doc: Directory in which to write the Cell Browser files.
    inputBinding:
      position: 2
      prefix: --output-directory=
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
  - id: study_name
    type:
      - 'null'
      - string
    doc: Study name to be displayed in CellBrowser
    inputBinding:
      position: 4
      prefix: --study-name=
      separate: false
  - id: markers_file
    type:
      - 'null'
      - File
    doc: Path to markers file computed by Seurat
    inputBinding:
      position: 5
      prefix: --markers-file=
      separate: false
outputs:
  - id: cellbrowser_directory
    type: Directory
    doc: Directory with the Cell Browser files.
    outputBinding:
      glob: $(inputs.output_directory)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: $(inputs.output_directory)
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/seurat-scripts:4.4.0--hdfd78af_0
