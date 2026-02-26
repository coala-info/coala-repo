cwlVersion: v1.2
class: CommandLineTool
baseCommand: compare
label: ngs-smap_smap compare
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
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ngs-smap:5.0.1--pyhdfd78af_0
stdout: ngs-smap_smap compare.out
