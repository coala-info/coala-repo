cwlVersion: v1.2
class: CommandLineTool
baseCommand: taxonomy-reader
label: gb_taxonomy_tools_taxonomy-reader
doc: "Reads GenBank taxonomic information from the NCBI names and nodes files and expands each taxonomy ID read from standard input into a full 22-level taxonomy.\n\nTool homepage: https://github.com/spond/gb_taxonomy_tools"
inputs:
  - id: names_file
    type: File
    doc: "GenBank taxid to name map file (e.g. taxdump/names from ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz)"
    inputBinding:
      position: 1
  - id: nodes_file
    type: File
    doc: "GenBank taxonomic hierarchy file (e.g. taxdump/nodes from ftp://ftp.ncbi.nih.gov/pub/taxonomy/taxdump.tar.gz)"
    inputBinding:
      position: 2
  - id: taxid_field_index
    type:
      - 'null'
      - int
    doc: "Integer index (0-based) of the field containing the tax ID in each tab-separated input line; the default is field 1"
    inputBinding:
      position: 3
  - id: input_triplets
    type: File
    doc: "Tab-separated lines of GenBank ID, tax ID and count (the output of gid-taxid), read from standard input"
outputs:
  - id: stdout
    type: stdout
    doc: Tab-separated lines with the count, the tax ID and the 22-level taxonomy
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
stdin: $(inputs.input_triplets.path)
stdout: gb_taxonomy_tools_taxonomy-reader.out
