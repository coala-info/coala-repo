cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - methylpy
  - index-allc
label: methylpy_index-allc
doc: "Index ALLC files for faster access.\n\nTool homepage: https://github.com/yupenghe/methylpy"
inputs:
  - id: allc_files
    type:
      type: array
      items: File
    doc: List of allc files to index.
    inputBinding:
      position: 101
      prefix: --allc-files
  - id: num_procs
    type:
      - 'null'
      - int
    doc: Number of processors to use
    default: 1
    inputBinding:
      position: 101
      prefix: --num-procs
  - id: reindex
    type:
      - 'null'
      - boolean
    doc: Boolean indicating whether to index allc files whose index files 
      already exist.
    default: true
    inputBinding:
      position: 101
      prefix: --reindex
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
stdout: methylpy_index-allc.out
