cwlVersion: v1.2
class: CommandLineTool
baseCommand: gsearch_add
label: gsearch_add
doc: "Add new genome files to a pre-built HNSW graph database\n\nTool homepage: https://github.com/jean-pierreBoth/gsearch"
inputs:
  - id: hnsw_dir
    type: Directory
    doc: set the name of directory containing already constructed hnsw data
    inputBinding:
      position: 101
      prefix: --hnsw
  - id: newdata_dir
    type: Directory
    doc: set directory containing new data
    inputBinding:
      position: 101
      prefix: --new
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gsearch:0.3.4--hafc0c1d_0
stdout: gsearch_add.out
