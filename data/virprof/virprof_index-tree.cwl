cwlVersion: v1.2
class: CommandLineTool
baseCommand: virprof index-tree
label: virprof_index-tree
doc: "Parse NCBI taxonomy from dump files and write tree to binary\n\nTool homepage:
  https://github.com/seiboldlab/virprof"
inputs:
  - id: library
    type:
      - 'null'
      - string
    doc: Tree library to use
    inputBinding:
      position: 101
      prefix: --library
  - id: ncbi_taxonomy_path
    type: Directory
    doc: Path to the NCBI taxonomy dump directory
    inputBinding:
      position: 101
      prefix: --ncbi-taxonomy
outputs:
  - id: output_filename
    type: File
    doc: Output binary
    outputBinding:
      glob: $(inputs.output_filename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/virprof:0.9.2--pyhdfd78af_0
