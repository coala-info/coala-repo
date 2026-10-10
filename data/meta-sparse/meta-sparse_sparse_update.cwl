cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sparse
  - update
label: meta-sparse_sparse_update
doc: "Update metadata of references in a SPARSE database.\n\nTool homepage: https://github.com/zheminzhou/SPARSE"
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
  - id: seqlist
    type: File
    doc: "Tab-delimited list of references in the same format as the output of sparse query"
    inputBinding:
      position: 2
      prefix: --seqlist
outputs:
  - id: stdout
    type: stdout
    doc: Table of updated fields
  - id: database
    type: Directory
    doc: "Updated SPARSE database folder"
    outputBinding:
      glob: $(inputs.dbname.basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/meta-sparse:0.1.12--py27h24bf2e0_0
stdout: meta-sparse_sparse_update.out
