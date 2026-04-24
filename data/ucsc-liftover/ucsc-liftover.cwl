cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftOver
label: ucsc-liftover
doc: "Move annotations from one assembly to another using a chain file.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: old_file
    type: File
    doc: Input file to be converted (e.g., BED, GFF, etc.)
    inputBinding:
      position: 1
  - id: chain_file
    type: File
    doc: UCSC chain file for the conversion
    inputBinding:
      position: 2
  - id: bed_plus
    type:
      - 'null'
      - int
    doc: File is BED N+ format
    inputBinding:
      position: 103
      prefix: -bedPlus
  - id: gff
    type:
      - 'null'
      - boolean
    doc: Input is in GFF format
    inputBinding:
      position: 103
      prefix: -gff
  - id: min_chain_q
    type:
      - 'null'
      - int
    doc: Minimum chain size in query
    inputBinding:
      position: 103
      prefix: -minChainQ
  - id: min_chain_t
    type:
      - 'null'
      - int
    doc: Minimum chain size in target
    inputBinding:
      position: 103
      prefix: -minChainT
  - id: min_match
    type:
      - 'null'
      - float
    doc: Minimum ratio of bases that must remap
    inputBinding:
      position: 103
      prefix: -minMatch
  - id: min_size_q
    type:
      - 'null'
      - int
    doc: Minimum size of query region
    inputBinding:
      position: 103
      prefix: -minSizeQ
  - id: multiple
    type:
      - 'null'
      - boolean
    doc: Allow multiple output regions for a single input region
    inputBinding:
      position: 103
      prefix: -multiple
  - id: tab
    type:
      - 'null'
      - boolean
    doc: File is tab-delimited
    inputBinding:
      position: 103
      prefix: -tab
outputs:
  - id: new_file
    type: File
    doc: Output file for successfully mapped coordinates
    outputBinding:
      glob: '*.out'
  - id: unmapped_file
    type: File
    doc: Output file for coordinates that could not be mapped
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-liftover:482--h0b57e2e_0
