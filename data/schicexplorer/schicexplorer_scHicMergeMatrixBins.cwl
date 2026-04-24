cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicMergeMatrixBins
label: schicexplorer_scHicMergeMatrixBins
doc: "Merges bins from a Hi-C matrix. For example, using a matrix containing 5kb\n\
  bins, a matrix of 50kb bins can be derived using --numBins 10.\n\nTool homepage:
  https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: matrix
    type: File
    doc: Matrix to reduce in scool format.
    inputBinding:
      position: 101
      prefix: --matrix
  - id: num_bins
    type: int
    doc: Number of bins to merge.
    inputBinding:
      position: 101
      prefix: --numBins
  - id: running_window
    type:
      - 'null'
      - boolean
    doc: "set to merge for using a running window of length\n--numBins. Must be an
      odd number."
    inputBinding:
      position: 101
      prefix: --runningWindow
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads. Using the python multiprocessing\nmodule."
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: out_file_name
    type: File
    doc: "File name to save the resulting matrix. The output is\nalso a .scool file.
      But don't add the suffix."
    outputBinding:
      glob: $(inputs.out_file_name)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
