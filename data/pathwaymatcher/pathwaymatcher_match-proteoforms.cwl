cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - PathwayMatcher.jar
  - match-proteoforms
label: pathwaymatcher_match-proteoforms
doc: "Match a list of proteoforms to reactions and pathways\n\nTool homepage: https://github.com/LuisFranciscoHS/PathwayMatcher"
inputs:
  - id: graph
    type:
      - 'null'
      - boolean
    doc: Create default connection graph according to input type.
    inputBinding:
      position: 101
      prefix: --graph
  - id: graph_gene
    type:
      - 'null'
      - boolean
    doc: Create gene connection graph
    inputBinding:
      position: 101
      prefix: --graphGene
  - id: graph_proteoform
    type:
      - 'null'
      - boolean
    doc: Create proteoform connection graph
    inputBinding:
      position: 101
      prefix: --graphProteoform
  - id: graph_uniprot
    type:
      - 'null'
      - boolean
    doc: Create protein connection graph
    inputBinding:
      position: 101
      prefix: --graphUniprot
  - id: input
    type: File
    doc: Input file with path
    inputBinding:
      position: 101
      prefix: --input
  - id: mapping
    type:
      - 'null'
      - Directory
    doc: Path to directory with the static mapping files. By default uses the mapping
      files integrated in the jar file.
    inputBinding:
      position: 101
      prefix: --mapping
  - id: match_type
    type:
      - 'null'
      - string
    doc: 'Proteoform match criteria. Valid values: STRICT, SUPERSET, SUPERSET_NO_TYPES,
      SUBSET, SUBSET_NO_TYPES, ONE, ONE_NO_TYPES.'
    inputBinding:
      position: 101
      prefix: --matchType
  - id: range
    type:
      - 'null'
      - int
    doc: Integer range of error for PTM sites.
    inputBinding:
      position: 101
      prefix: --range
  - id: top_level_pathways
    type:
      - 'null'
      - boolean
    doc: Show Top Level Pathways in the search result.
    inputBinding:
      position: 101
      prefix: --topLevelPathways
outputs:
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: 'Path and prefix for the output files: search.tsv (list of reactions and
      pathways containing the input), analysis.tsv (over-representation analysis)
      and networks files.'
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pathwaymatcher:1.9.1--1
