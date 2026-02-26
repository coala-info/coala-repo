cwlVersion: v1.2
class: CommandLineTool
baseCommand: mapper
label: smallgenomeutilities_mapper
doc: "Mapper tool\n\nTool homepage: https://github.com/cbg-ethz/smallgenomeutilities"
inputs:
  - id: msa_file
    type: File
    doc: file containing MSA
    inputBinding:
      position: 1
  - id: dest
    type: string
    doc: Name of target contig
    inputBinding:
      position: 102
      prefix: -t
  - id: one_based_coordinates
    type:
      - 'null'
      - boolean
    doc: Whether coordinates should be treated 1-based
    inputBinding:
      position: 102
      prefix: '-1'
  - id: source
    type: string
    doc: Name and Coordinates of source contig, e.g. CONSENSUS:100-200
    inputBinding:
      position: 102
      prefix: -f
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print more information (such as subsequences in references)
    inputBinding:
      position: 102
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/smallgenomeutilities:0.5.2--pyhdfd78af_0
stdout: smallgenomeutilities_mapper.out
