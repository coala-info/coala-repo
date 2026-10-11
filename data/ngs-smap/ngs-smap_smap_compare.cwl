cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - smap
  - compare
label: ngs-smap_smap_compare
doc: "Compare merged clusters of two SMAP outputs.\n\nTool homepage: https://gitlab.com/truttink/smap"
inputs:
  - id: smap_set1
    type: File
    doc: SMAP delineate output BED file for set 1
    inputBinding:
      position: 1
  - id: smap_set2
    type: File
    doc: SMAP delineate output BED file for set 2.
    inputBinding:
      position: 2
outputs:
  - id: output_files
    type:
      type: array
      items: File
    doc: Comparison tables and plots written by SMAP compare
    outputBinding:
      glob:
        - "*.tsv"
        - "*.png"
        - "*.pdf"
        - "*.bed"
        - "*.txt"
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
