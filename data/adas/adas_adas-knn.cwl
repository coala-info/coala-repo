cwlVersion: v1.2
class: CommandLineTool
baseCommand: adas-knn
label: adas_adas-knn
doc: "Extract K Nearest Neighbors (K-NN) from HNSW graph.\n\nTool homepage: https://github.com/jianshu93/adas"
inputs:
  - id: hnsw
    type: Directory
    doc: Directory containing pre-built HNSW database files
    inputBinding:
      position: 101
      prefix: --hnsw
  - id: k_nearest_neighbors
    type:
      - 'null'
      - int
    doc: Number of k-nearest-neighbors to extract
    inputBinding:
      position: 101
      prefix: --k-nearest-neighbors
  - id: output_path
    type: string
    doc: Output or path parameter `output_path`
    inputBinding:
      position: 102
      prefix: --output
outputs:
  - id: output
    type: File
    doc: Output path to write the neighbor list (sequence IDs)
    outputBinding:
      glob: $(inputs.output_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/adas:0.1.3--h3ab6199_0
