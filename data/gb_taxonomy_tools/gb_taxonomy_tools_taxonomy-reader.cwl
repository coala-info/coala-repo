cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonomy-reader
label: gb_taxonomy_tools_taxonomy-reader
doc: "Reads GenBank taxonomic information from provided map and hierarchy files.\n\
  \nTool homepage: https://github.com/spond/gb_taxonomy_tools"
inputs:
  - id: names_file
    type: File
    doc: GenBank taxid to name map file (e.g. taxdump/names from 
      ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz)
    inputBinding:
      position: 1
  - id: nodes_file
    type: File
    doc: GenBank taxonomic hierarchy file (e.g. taxdump/nodes from 
      ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz)
    inputBinding:
      position: 2
  - id: taxid_field_index
    type:
      - 'null'
      - int
    doc: integer index (0-based) of the field containing tax ID in each 
      tab-separated input line; the default is field 1
    default: 0
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
stdout: gb_taxonomy_tools_taxonomy-reader.out
