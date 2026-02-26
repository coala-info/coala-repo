cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - snaptools
  - snap-add-bmat
label: snaptools_snap-add-bmat
doc: "Add cell-by-bin count matrix to snap file.\n\nTool homepage: https://github.com/r3fang/SnapTools.git"
inputs:
  - id: bin_size_list
    type:
      - 'null'
      - type: array
        items: int
    doc: a list of bin size(s) to create the cell-by-bin count matrix. The 
      genome will be divided into bins of the equal size of --bin-size-list to 
      create the cell x bin count matrix. If more than one bin size are given, 
      snaptools will generate a list of cell x bin matrices of different 
      resolutions and stored in the same snap file.
    default:
      - 5000
    inputBinding:
      position: 101
      prefix: --bin-size-list
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
    default: true
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
stdout: snaptools_snap-add-bmat.out
