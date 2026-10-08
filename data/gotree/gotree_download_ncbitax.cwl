cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - download
  - ncbitax
label: gotree_download_ncbitax
doc: "Downloads the full ncbi taxonomy in newick format.\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: map_file_path
    type:
      - 'null'
      - string
    doc: "Output mapping file between taxid and species name (tab separated)"
    inputBinding:
      position: 101
      prefix: --map
  - id: nodes_taxid
    type:
      - 'null'
      - boolean
    doc: "Keeps tax id as internal nodes identifiers"
    inputBinding:
      position: 101
      prefix: --nodes-taxid
  - id: output_file_path
    type: string
    doc: "NCBI newick output file"
    inputBinding:
      position: 101
      prefix: --output
  - id: tips_taxid
    type:
      - 'null'
      - boolean
    doc: "Keeps tax id as tip names"
    inputBinding:
      position: 101
      prefix: --tips-taxid
  - id: tree_format
    type:
      - 'null'
      - string
    doc: "Input tree format (newick, nexus, phyloxml, or nextstrain)"
    inputBinding:
      position: 101
      prefix: --format
  - id: seed
    type:
      - 'null'
      - int
    doc: "Random Seed: -1 = nano seconds since 1970/01/01 00:00:00"
    inputBinding:
      position: 101
      prefix: --seed
  - id: threads
    type:
      - 'null'
      - int
    doc: "Number of threads (Max=20)"
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: map_file
    type:
      - 'null'
      - File
    doc: "Output mapping file between taxid and species name (tab separated)"
    outputBinding:
      glob: "$(inputs.map_file_path)"
  - id: output_file
    type: File
    doc: "Output file written to the path in output_file_path"
    outputBinding:
      glob: "$(inputs.output_file_path)"
requirements:
  - class: NetworkAccess
    networkAccess: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gotree:0.5.1--he881be0_0
