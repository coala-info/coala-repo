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
    doc: List of allc files to index (staged writable, the .idx files are written
      beside them).
    inputBinding:
      position: 101
      prefix: --allc-files
      valueFrom: $(self.map(function(f) { return f.basename; }))
  - id: num_procs
    type:
      - 'null'
      - int
    doc: Number of processors to use
    inputBinding:
      position: 101
      prefix: --num-procs
  - id: reindex
    type:
      - 'null'
      - string
    doc: Boolean indicating whether to index allc files whose index files 
      already exist.
    inputBinding:
      position: 101
      prefix: --reindex
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
  - id: index_files
    type:
      type: array
      items: File
    doc: Index files (.idx), one per allc file
    outputBinding:
      glob: '*.idx'
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.allc_files)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/methylpy:1.4.7--py39h0ae133c_0
stdout: methylpy_index-allc.out
