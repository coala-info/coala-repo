cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - gotree
  - download
  - panther
label: gotree_download_panther
doc: "Downloads a panther family tree from panther (http://pantherdb.org/).\n\nTool homepage: https://github.com/fredericlemoine/gotree"
inputs:
  - id: family_id
    type: string
    doc: "Panther Family ID to download"
    inputBinding:
      position: 101
      prefix: --family-id
  - id: output_file_path
    type: string
    doc: "Panther family newick output file"
    inputBinding:
      position: 101
      prefix: --output
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
