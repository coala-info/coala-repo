cwlVersion: v1.2
class: CommandLineTool
baseCommand: rsem-generate-data-matrix
label: rsem_rsem-generate-data-matrix
doc: "All result files should have the same file type. The 'expected_count' columns
  of every result file are extracted to form the data matrix.\n\nTool homepage: https://deweylab.github.io/RSEM/"
inputs:
  - id: result_files
    type:
      type: array
      items: File
    doc: Input result files (e.g., sampleA.genes.results)
    inputBinding:
      position: 1
outputs:
  - id: output_matrix
    type: stdout
    doc: Data matrix of the expected_count columns of all result files
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rsem:1.3.3--pl5321h077b44d_12
stdout: rsem-generate-data-matrix.matrix
