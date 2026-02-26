cwlVersion: v1.2
class: CommandLineTool
baseCommand: scaden simulate
label: scaden_simulate
doc: "Create artificial bulk RNA-seq data from scRNA-seq dataset(s)\n\nTool homepage:
  https://github.com/KevinMenden/scaden"
inputs:
  - id: cells_per_sample
    type:
      - 'null'
      - int
    doc: Number of cells per sample
    default: 100
    inputBinding:
      position: 101
      prefix: --cells
  - id: data_format
    type:
      - 'null'
      - string
    doc: Data format of scRNA-seq data, can be 'txt' or 'h5ad'
    default: txt
    inputBinding:
      position: 101
      prefix: --data-format
  - id: data_path
    type:
      - 'null'
      - File
    doc: Path to scRNA-seq dataset(s)
    inputBinding:
      position: 101
      prefix: --data
  - id: file_pattern
    type:
      - 'null'
      - string
    doc: File pattern to recognize your processed scRNA-seq count files
    inputBinding:
      position: 101
      prefix: --pattern
  - id: num_samples
    type:
      - 'null'
      - int
    doc: Number of samples to simulate
    default: 1000
    inputBinding:
      position: 101
      prefix: --n_samples
  - id: training_prefix
    type:
      - 'null'
      - string
    doc: Prefix to append to training .h5ad file
    default: data
    inputBinding:
      position: 101
      prefix: --prefix
  - id: unknown_cell_types
    type:
      - 'null'
      - type: array
        items: string
    doc: Specifiy cell types to merge into the unknown category. Specify this 
      flag for every cell type you want to merge in unknown.
    default: unknown
    inputBinding:
      position: 101
      prefix: --unknown
outputs:
  - id: out_dir
    type:
      - 'null'
      - Directory
    doc: Directory to store output files in
    outputBinding:
      glob: $(inputs.out_dir)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/scaden:1.1.2--pyhdfd78af_0
