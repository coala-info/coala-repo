cwlVersion: v1.2
class: CommandLineTool
baseCommand: make_ktaxonomy.py
label: krakentools_make_ktaxonomy.py
doc: "Make a taxonomy file for make_kreport.py from NCBI taxonomy nodes.dmp and names.dmp and a seqid2taxid map.\n\nTool homepage: https://github.com/jenniferlu717/KrakenTools"
inputs:
  - id: nodes_file
    type: File
    doc: "nodes.dmp file from taxonomy"
    inputBinding:
      position: 1
      prefix: --nodes
  - id: names_file
    type: File
    doc: "names.dmp file from taxonomy"
    inputBinding:
      position: 1
      prefix: --names
  - id: seqid2taxid
    type: File
    doc: "seqid2taxid.map file"
    inputBinding:
      position: 1
      prefix: --seqid2taxid
  - id: output_file_path
    type: string
    doc: "Output taxonomy file"
    inputBinding:
      position: 102
      prefix: -o
outputs:
  - id: output_file
    type: File
    doc: "Taxonomy file"
    outputBinding:
      glob: $(inputs.output_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/krakentools:1.2.1--pyh7e72e81_0
