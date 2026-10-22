cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicMergeToSCool
label: schicexplorer_scHicMergeToSCool
doc: "Creates out of n cool files one scool file.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: matrices
    type:
      type: array
      items: File
    doc: "input file(s)."
    inputBinding:
      position: 101
      prefix: --matrices
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
    doc: "File name to save the exported matrix."
    inputBinding:
      position: 102
      prefix: --outFileName
outputs:
  - id: out_file_name
    type:
      - 'null'
      - File
    doc: "Merged scool matrix"
    outputBinding:
      glob: "$(inputs.out_file_name_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
