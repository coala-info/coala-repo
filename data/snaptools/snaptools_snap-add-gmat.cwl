cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snaptools
  - snap-add-gmat
label: snaptools_snap-add-gmat
doc: "Add gene matrix to snap file.\n\nTool homepage: https://github.com/r3fang/SnapTools.git"
inputs:
  - id: buffer_size
    type:
      - 'null'
      - int
    doc: max number of barcodes be stored in the memory.
    inputBinding:
      position: 101
      prefix: --buffer-size
  - id: gene_file
    type: File
    doc: bed file contains genes.
    inputBinding:
      position: 101
      prefix: --gene-file
  - id: snap_file
    type: File
    doc: snap file.
    inputBinding:
      position: 101
      prefix: --snap-file
  - id: tmp_folder
    type:
      - 'null'
      - Directory
    doc: a directory to store temporary files. If not given, snaptools will 
      automatically generate a temporary location to store temporary files.
    inputBinding:
      position: 101
      prefix: --tmp-folder
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: a boolen tag indicates output the progress.
    inputBinding:
      position: 101
      prefix: --verbose
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/snaptools:1.4.8--py_0
stdout: snaptools_snap-add-gmat.out
