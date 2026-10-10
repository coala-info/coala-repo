cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sparse
  - predict
label: meta-sparse_sparse_predict
doc: "Alignment based taxonomy prediction of reads against SPARSE mapping databases.\n\nTool homepage: https://github.com/zheminzhou/SPARSE"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.dbname)
        writable: true
inputs:
  - id: dbname
    type: Directory
    doc: "SPARSE database folder (created by sparse init); staged writable in the working directory"
    inputBinding:
      position: 1
      prefix: --dbname
      valueFrom: $(self.basename)
  - id: mapdb
    type: 
      - 'null'
      - string
    doc: "Comma delimited names for sub-databases. Default: representative,subpopulation,Virus"
    inputBinding:
      position: 2
      prefix: --mapDB
  - id: workspace
    type: string
    doc: "Folder name for all outputs and intermediate results"
    inputBinding:
      position: 3
      prefix: --workspace
  - id: r1
    type: File
    doc: "SE read or first part of PE reads"
    inputBinding:
      position: 4
      prefix: --r1
  - id: r2
    type: 
      - 'null'
      - File
    doc: "Second part of PE reads"
    inputBinding:
      position: 5
      prefix: --r2
  - id: n_thread
    type: 
      - 'null'
      - int
    doc: "Number of threads to use. Default: 20"
    inputBinding:
      position: 6
      prefix: --n_thread
outputs:
  - id: workspace_out
    type: Directory
    doc: "Workspace folder with the prediction results"
    outputBinding:
      glob: $(inputs.workspace)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-sparse:0.1.12--py27h24bf2e0_0
stdout: meta-sparse_sparse_predict.out
