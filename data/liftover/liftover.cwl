cwlVersion: v1.2
class: CommandLineTool
baseCommand: liftOver
label: liftover
doc: "Converts genome coordinates between assemblies using a chain file.\n\nTool homepage:
  https://github.com/jeremymcrae/liftover"
inputs:
  - id: old_file
    type: File
    doc: Input file in BED, GFF, or other supported format.
    inputBinding:
      position: 1
  - id: chain_file
    type: File
    doc: The mapping file (usually .chain or .over.chain) that defines the transformation.
    inputBinding:
      position: 2
  - id: bed_plus
    type:
      - 'null'
      - int
    doc: File is BED N+ format (e.g., -bedPlus=4).
    inputBinding:
      position: 103
      prefix: -bedPlus
  - id: gff
    type:
      - 'null'
      - boolean
    doc: Input is in GFF format.
    inputBinding:
      position: 103
      prefix: -gff
  - id: min_chain_q
    type:
      - 'null'
      - int
    doc: Minimum chain size in query.
    inputBinding:
      position: 103
      prefix: -minChainQ
  - id: min_chain_t
    type:
      - 'null'
      - int
    doc: Minimum chain size in target.
    inputBinding:
      position: 103
      prefix: -minChainT
  - id: min_match
    type:
      - 'null'
      - float
    doc: Minimum ratio of bases that must remap.
    inputBinding:
      position: 103
      prefix: -minMatch
  - id: multiple
    type:
      - 'null'
      - boolean
    doc: Allow multiple output regions for one input region.
    inputBinding:
      position: 103
      prefix: -multiple
  - id: tab
    type:
      - 'null'
      - boolean
    doc: Unmapped file will be tab-separated.
    inputBinding:
      position: 103
      prefix: -tab
outputs:
  - id: new_file
    type: File
    doc: Output file containing the successfully mapped coordinates.
    outputBinding:
      glob: '*.out'
  - id: unmapped_file
    type: File
    doc: Output file containing the coordinates that could not be mapped.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/liftover:1.3.3--py310h275bdba_0
