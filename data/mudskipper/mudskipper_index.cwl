cwlVersion: v1.2
class: CommandLineTool
baseCommand: mudskipper index
label: mudskipper_index
doc: "Parse the GTF and build an index to make later runs faster.\n\nTool homepage:
  https://github.com/OceanGenomics/mudskipper"
inputs:
  - id: dir_index
    type: Directory
    doc: Output index directory name
    inputBinding:
      position: 101
      prefix: --dir-index
  - id: gtf
    type: File
    doc: Input GTF/GFF file
    inputBinding:
      position: 101
      prefix: --gtf
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mudskipper:0.1.0--h7d875b9_0
stdout: mudskipper_index.out
