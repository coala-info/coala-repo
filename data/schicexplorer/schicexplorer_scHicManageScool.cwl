cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicManageScool
label: schicexplorer_scHicManageScool
doc: "This script offers methods to extract cool files or to update a scool file for scHiCExplorer version 5.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: matrix
    type: File
    doc: "The scool matrix"
    inputBinding:
      position: 101
      prefix: --matrix
  - id: action
    type:
      - 'null'
      - string
    doc: "The different actions this tool is able to do (update, extractToCool, extractScool; default: none)"
    inputBinding:
      position: 101
      prefix: --action
  - id: cell_list
    type:
      - 'null'
      - File
    doc: "A text file with the cells that should be extracted or copied to the a new scool file."
    inputBinding:
      position: 101
      prefix: --cellList
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads. Using the python multiprocessing module."
    inputBinding:
      position: 101
      prefix: --threads
  - id: out_file_name_path
    type: string
    doc: "File name to save the exported matrix, in case of extract the folder name"
    inputBinding:
      position: 102
      prefix: --outFileName
outputs:
  - id: out_file_name
    type:
      - 'null'
      - File
      - Directory
    doc: "Exported matrix (update, extractScool) or folder with the extracted cool files (extractToCool)"
    outputBinding:
      glob: "$(inputs.out_file_name_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
