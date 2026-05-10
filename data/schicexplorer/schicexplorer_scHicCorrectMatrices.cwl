cwlVersion: v1.2
class: CommandLineTool
baseCommand: schicexplorer_scHicCorrectMatrices
label: schicexplorer_scHicCorrectMatrices
doc: "Correct each matrix of the given scool matrix with KR correction.\n\nTool homepage:
  https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: matrix
    type: File
    doc: Matrix to reduce in h5 format.
    inputBinding:
      position: 101
      prefix: --matrix
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. Using the python multiprocessing module.
    inputBinding:
      position: 101
      prefix: --threads
  - id: out_file_name_path
    type: string
    doc: Output or path parameter `out_file_name_path`
    inputBinding:
      position: 102
      prefix: --out-file-name
outputs:
  - id: out_file_name
    type: File
    doc: File name to save the resulting matrix, please add the scool prefix.
    outputBinding:
      glob: $(inputs.out_file_name_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
