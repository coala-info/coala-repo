cwlVersion: v1.2
class: CommandLineTool
baseCommand: megagta_findstart
label: megagta_findstart
doc: "Find the start of the first exon in a gene.\n\nTool homepage: https://github.com/HKU-BAL/MegaGTA"
inputs:
  - id: gene_file
    type: File
    doc: A gene file in GTF format.
    inputBinding:
      position: 1
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: The output file to write the results to.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/megagta:0.1_alpha--0
