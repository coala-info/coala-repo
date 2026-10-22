cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicTxtToSCool
label: schicexplorer_scHicTxtToSCool
doc: "Creates out of n txt files from Ramani 2017 one scool file.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: matrices
    type:
      type: array
      items: File
    doc: "input file(s)."
    inputBinding:
      position: 101
      prefix: --matrices
  - id: chromosome_sizes
    type: File
    doc: "Text file with two columns, first column is the name of the chromosome, second one its length."
    inputBinding:
      position: 101
      prefix: --chromosomeSizes
  - id: resolution
    type: int
    doc: "The resolution of the matrix."
    inputBinding:
      position: 101
      prefix: --resolution
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
    doc: "File name to save the scool matrix."
    inputBinding:
      position: 102
      prefix: --outFileName
outputs:
  - id: out_file_name
    type:
      - 'null'
      - File
    doc: "Scool matrix"
    outputBinding:
      glob: "$(inputs.out_file_name_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
