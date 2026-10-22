cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicConvertFormat
label: schicexplorer_scHicConvertFormat
doc: "scHicConvertFormat is a tool to convert a scool matrix to other single-cell Hi-C formats. So far only the structure of scHiCluster is supported.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: matrix
    type: File
    doc: "The matrix to convert in the scool format."
    inputBinding:
      position: 101
      prefix: --matrix
  - id: output_folder_path
    type: string
    doc: "Folder name to save the files"
    inputBinding:
      position: 102
      prefix: --outputFolder
  - id: output_cell_name_file_path
    type:
      - 'null'
      - string
    doc: "File name to save the cell names and their location (default: cellNameFile.txt)"
    inputBinding:
      position: 102
      prefix: --outputCellNameFile
  - id: output_chromosome_size_path
    type:
      - 'null'
      - string
    doc: "File name to save the chromosome sizes (default: chromosomeSize.txt)"
    inputBinding:
      position: 102
      prefix: --outputChromosomeSize
  - id: format
    type:
      - 'null'
      - string
    doc: "The format of the output files (schicluster, sparse-matrix-files; default: schicluster)"
    inputBinding:
      position: 101
      prefix: --format
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads. Using the python multiprocessing module."
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output_folder
    type:
      - 'null'
      - Directory
    doc: "Folder with the converted files"
    outputBinding:
      glob: "$(inputs.output_folder_path)"
  - id: output_cell_name_file
    type:
      - 'null'
      - File
    doc: "Cell names and their location"
    outputBinding:
      glob: "$(inputs.output_cell_name_file_path)"
  - id: output_chromosome_size
    type:
      - 'null'
      - File
    doc: "Chromosome sizes"
    outputBinding:
      glob: "$(inputs.output_chromosome_size_path)"
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
