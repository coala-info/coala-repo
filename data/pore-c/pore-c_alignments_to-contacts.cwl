cwlVersion: v1.2
class: CommandLineTool
baseCommand: [pore_c, alignments, to-contacts]
label: pore-c_alignments_to-contacts
doc: "Convert the alignment table to a pairwise contact table.\n\nTool homepage: https://github.com/nanoporetech/pore-c"
inputs:
  - id: pore_c_table
    type: File
    doc: "Pore-C table (parquet)"
    inputBinding:
      position: 10
  - id: contact_table
    type: string
    doc: "Output contact table (parquet)"
    inputBinding:
      position: 11
outputs:
  - id: contacts
    type: File
    doc: "Pairwise contact table (parquet)"
    outputBinding:
      glob: "$(inputs.contact_table)"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pore-c:0.4.0--pyhdfd78af_0
