cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicInfo
label: schicexplorer_scHicInfo
doc: "Prints information about a scool matrix: the number of cells, the bins and the chromosomes.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: matrix
    type: File
    doc: "The single cell Hi-C interaction matrices to investigate. Needs to be in scool format"
    inputBinding:
      position: 101
      prefix: --matrix
  - id: write_out_names_path
    type:
      - 'null'
      - string
    doc: "Write out the names of the individual cells to the here specified file."
    inputBinding:
      position: 102
      prefix: --writeOutNames
outputs:
  - id: write_out_names
    type:
      - 'null'
      - File
    doc: "File with the names of the cells"
    outputBinding:
      glob: "$(inputs.write_out_names_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
