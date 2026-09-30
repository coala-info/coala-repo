cwlVersion: v1.2
class: CommandLineTool
baseCommand: autoDtd
label: ucsc-autodtd_autoDtd
doc: "Give this a XML document to look at and it will come up with a DTD to describe
  it.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_xml
    type: File
    doc: XML document to process
    inputBinding:
      position: 1
  - id: output_attributed_tree_path
    type:
      - 'null'
      - string
    doc: =out.atree - Output attributed tag tree.
    inputBinding:
      position: 101
      prefix: -atree=
      separate: false
  - id: output_tree_path
    type:
      - 'null'
      - string
    doc: =out.tree - Output tag tree.
    inputBinding:
      position: 102
      prefix: -tree=
      separate: false
outputs:
  - id: output_dtd
    type: File
    doc: Output DTD file
    outputBinding:
      glob: '*.out'
  - id: output_stats
    type: File
    doc: Output statistics file
    outputBinding:
      glob: '*.out'
  - id: output_tree
    type:
      - 'null'
      - File
    doc: Output tag tree
    outputBinding:
      glob: $(inputs.output_tree_path)
  - id: output_attributed_tree
    type:
      - 'null'
      - File
    doc: Output attributed tag tree
    outputBinding:
      glob: $(inputs.output_attributed_tree_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-autodtd:482--h0b57e2e_0
