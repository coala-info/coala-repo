cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicCreateBulkMatrix
label: schicexplorer_scHicCreateBulkMatrix
doc: "Creates a bulk Hi-C matrix (cool format) by summing all single-cell matrices of a scool file.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: matrix
    type: File
    doc: "The single cell Hi-C interaction matrices to sum. Needs to be in scool format"
    inputBinding:
      position: 101
      prefix: --matrix
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
    doc: "File name to save the exported cooler matrix. Please add .cool appendix."
    inputBinding:
      position: 102
      prefix: --outFileName
outputs:
  - id: out_file_name
    type:
      - 'null'
      - File
    doc: "Bulk cool matrix"
    outputBinding:
      glob: "$(inputs.out_file_name_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
