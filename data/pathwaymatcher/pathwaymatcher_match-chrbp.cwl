cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - java
  - -jar
  - PathwayMatcher.jar
  - match-chrbp
label: pathwaymatcher_match-chrbp
doc: "Match a list of genetic variants as chromosome and base pairs\n\nTool homepage:
  https://github.com/LuisFranciscoHS/PathwayMatcher"
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
  - id: input_path
    type: File
    doc: Input file with path
    inputBinding:
      position: 101
      prefix: --input
  - id: mapping_path
    type:
      - 'null'
      - Directory
    doc: Path to directory with the static mapping files. By default uses the mapping
      files integrated in the jar file.
    inputBinding:
      position: 101
      prefix: --mapping
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
