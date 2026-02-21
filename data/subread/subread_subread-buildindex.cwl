cwlVersion: v1.2
class: CommandLineTool
baseCommand: subread-buildindex
label: subread_subread-buildindex
doc: "Build an index for a reference genome for the Subread aligner.\n\nTool homepage:
  https://subread.sourceforge.net"
inputs:
  - id: reference_files
    type:
      type: array
      items: File
    doc: List of FASTA files containing the reference sequences
    inputBinding:
      position: 1
  - id: full_index
    type:
      - 'null'
      - boolean
    doc: Build a full index for the reference genome (16bp step size). If not specified,
      a gapped index is built (2bp step size).
    inputBinding:
      position: 102
      prefix: -F
  - id: index_split
    type:
      - 'null'
      - boolean
    doc: Specify the threshold for the number of fragments in the index
    inputBinding:
      position: 102
      prefix: -f
  - id: memory_usage
    type:
      - 'null'
      - int
    doc: Size of computer memory (RAM) in megabytes that will be used for index building
    inputBinding:
      position: 102
      prefix: -M
  - id: single_index
    type:
      - 'null'
      - boolean
    doc: Create a single index file that contains all reference sequences
    inputBinding:
      position: 102
      prefix: -B
outputs:
  - id: output_basename
    type: File
    doc: Base name of the index to be created
    outputBinding:
      glob: $(inputs.output_basename)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/subread:2.1.1--h577a1d6_0
