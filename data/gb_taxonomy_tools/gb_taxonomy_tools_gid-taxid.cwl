cwlVersion: v1.2
class: CommandLineTool
baseCommand: gid-taxid
label: gb_taxonomy_tools_gid-taxid
doc: "Maps GenBank IDs to TaxIDs using a provided mapping file.\n\nTool homepage:
  https://github.com/spond/gb_taxonomy_tools"
inputs:
  - id: genbank_ids
    type:
      type: array
      items: string
    doc: A list of GenBank IDs to map.
    inputBinding:
      position: 1
  - id: mapping_file
    type: File
    doc: GenBank file mapping gids to taxids (gi_taxid files from 
      ftp://ftp.ncbi.nih.gov/pub/taxonomy/)
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
stdout: gb_taxonomy_tools_gid-taxid.out
