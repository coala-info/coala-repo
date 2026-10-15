cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, contacts, merge]
label: pore-c_contacts_merge
doc: "Merge contact tables.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: fofn
    type:
      - 'null'
      - boolean
    doc: "The source argument is a file of filenames of the contact tables to merge"
    inputBinding:
      position: 1
      prefix: --fofn
  - id: src_contact_tables
    type:
      type: array
      items: File
    doc: "Contact tables to merge (or a file of filenames with --fofn)"
    inputBinding:
      position: 10
  - id: dest_contact_table
    type: string
    doc: "Output merged contact table (parquet)"
    inputBinding:
      position: 11
outputs:
  - id: merged
    type: Directory
    doc: "Merged contact table (parquet dataset folder)"
    outputBinding:
      glob: "$(inputs.dest_contact_table)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
