cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bedtk
  - isec
label: bedtk_isec
doc: "Find intersections between two BED files\n\nTool homepage: https://github.com/lh3/bedtk"
inputs:
  - id: a_bed
    type: File
    doc: First BED file
    inputBinding:
      position: 1
  - id: b_bed
    type: File
    doc: Second BED file
    inputBinding:
      position: 2
  - id: contig_list_file
    type:
      - 'null'
      - File
    doc: list of contig IDs to specify the output order
    inputBinding:
      position: 103
      prefix: -s
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bedtk:1.2--h9990f68_0
stdout: bedtk_isec.out
