cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicAdjustMatrix
label: schicexplorer_scHicAdjustMatrix
doc: "scHicAdjustMatrix is a tool to keep or remove a list of chromosomes of all Hi-C matrices stored in the scool file.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: matrix
    type: File
    doc: "The matrix to adjust in the scool format."
    inputBinding:
      position: 101
      prefix: --matrix
  - id: chromosomes
    type:
      - 'null'
      - type: array
        items: string
    doc: "List of chromosomes to keep / remove"
    inputBinding:
      position: 101
      prefix: --chromosomes
  - id: create_submatrix
    type:
      - 'null'
      - int
    doc: "Keep only first n matrices and remove the rest. Good for test data creation."
    inputBinding:
      position: 101
      prefix: --createSubmatrix
  - id: action
    type:
      - 'null'
      - string
    doc: "Keep, remove or mask the list of specified chromosomes / regions (keep, remove)"
    inputBinding:
      position: 101
      prefix: --action
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
    doc: "File name to save the adjusted matrix."
    inputBinding:
      position: 102
      prefix: --outFileName
outputs:
  - id: out_file_name
    type:
      - 'null'
      - File
    doc: "Adjusted scool matrix"
    outputBinding:
      glob: "$(inputs.out_file_name_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
