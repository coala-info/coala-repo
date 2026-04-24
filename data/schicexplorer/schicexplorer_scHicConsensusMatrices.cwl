cwlVersion: v1.2
class: CommandLineTool
baseCommand: scHicConsensusMatrices
label: schicexplorer_scHicConsensusMatrices
doc: "scHicConsensusMatrices creates based on the clustered samples one consensus
  matrix for each cluster. The consensus matrices are normalized to an equal read
  coverage level and are stored all in one scool matrix.\n\nTool homepage: https://github.com/joachimwolff/scHiCExplorer"
inputs:
  - id: clusters
    type: File
    doc: Text file which contains per matrix the associated cluster.
    inputBinding:
      position: 101
      prefix: --clusters
  - id: matrix
    type: File
    doc: The single cell Hi-C interaction matrices to investigate for QC. Needs 
      to be in scool format
    inputBinding:
      position: 101
      prefix: --matrix
  - id: no_normalization
    type:
      - 'null'
      - boolean
    doc: Do not plot a header.
    inputBinding:
      position: 101
      prefix: --no_normalization
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads. Using the python multiprocessing module.
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: outFileName
    type: File
    doc: File name of the consensus scool matrix.
    outputBinding:
      glob: $(inputs.outFileName)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/schicexplorer:7--py_0
