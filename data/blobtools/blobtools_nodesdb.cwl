cwlVersion: v1.2
class: CommandLineTool
baseCommand: blobtools_nodesdb
label: blobtools_nodesdb
doc: "NCBI nodes.dmp and names.dmp files are required to build the database.\n\nTool
  homepage: https://blobtools.readme.io/docs/what-is-blobtools"
inputs:
  - id: names_file
    type: File
    doc: NCBI names.dmp file.
    inputBinding:
      position: 101
      prefix: --names
  - id: nodes_file
    type: File
    doc: NCBI nodes.dmp file.
    inputBinding:
      position: 101
      prefix: --nodes
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/blobtools:1.1.1--py_1
stdout: blobtools_nodesdb.out
