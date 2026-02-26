cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - sam2lca
  - update-db
label: sam2lca_update-db
doc: "Download/prepare acc2tax and taxonomy databases\n\nTool homepage: https://github.com/maxibor/sam2lca"
inputs:
  - id: acc2tax
    type:
      - 'null'
      - string
    doc: Type of acc2tax mapping database to build.
    inputBinding:
      position: 101
      prefix: --acc2tax
  - id: acc2tax_json
    type:
      - 'null'
      - string
    doc: JSON file for specifying extra acc2tax mappings
    default: 
      https://raw.githubusercontent.com/maxibor/sam2lca/master/data/acc2tax.json
    inputBinding:
      position: 101
  - id: taxo_merged
    type:
      - 'null'
      - File
    doc: merged.dmp file for Taxonomy database (optional). Only needed for 
      custom taxonomy database (non ncbi or gtdb)
    inputBinding:
      position: 101
  - id: taxo_names
    type:
      - 'null'
      - File
    doc: names.dmp file for Taxonomy database (optional). Only needed for custom
      taxonomy database (non ncbi or gtdb)
    inputBinding:
      position: 101
  - id: taxo_nodes
    type:
      - 'null'
      - File
    doc: nodes.dmp file for Taxonomy database (optional). Only needed for custom
      taxonomy database (non ncbi or gtdb)
    inputBinding:
      position: 101
  - id: taxonomy
    type:
      - 'null'
      - string
    doc: Name of taxonomy database to create (ncbi | gtdb)
    default: ncbi
    inputBinding:
      position: 101
      prefix: --taxonomy
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/sam2lca:1.1.4--pyhdfd78af_0
stdout: sam2lca_update-db.out
