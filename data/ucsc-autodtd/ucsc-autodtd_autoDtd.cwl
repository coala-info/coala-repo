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
      glob: $(inputs.output_tree)
  - id: output_attributed_tree
    type:
      - 'null'
      - File
    doc: Output attributed tag tree
    outputBinding:
      glob: $(inputs.output_attributed_tree)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-autodtd:482--h0b57e2e_0
