cwlVersion: v1.2
class: CommandLineTool
baseCommand: gid-taxid
label: gb_taxonomy_tools_gid-taxid
doc: "Converts a list of GenBank IDs and their counts into triplets of GenBank ID, taxonomy ID and count, using a GenBank gi-to-taxid mapping file.\n\nTool homepage: https://github.com/spond/gb_taxonomy_tools"
inputs:
  - id: genbank_ids_file
    type: File
    doc: "Tab-separated file with a GenBank ID and a count on each line"
    inputBinding:
      position: 1
  - id: mapping_file
    type: File
    doc: "GenBank file mapping gids to taxids (gi_taxid files from ftp://ftp.ncbi.nih.gov/pub/taxonomy/)"
    inputBinding:
      position: 2
outputs:
  - id: stdout
    type: stdout
    doc: Triplets of GenBank ID, taxonomy ID and count
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/gb_taxonomy_tools:1.0.1--h503566f_7
stdout: gb_taxonomy_tools_gid-taxid.out
