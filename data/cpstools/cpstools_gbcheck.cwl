cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cpstools
  - gbcheck
label: cpstools_gbcheck
doc: "Check GenBank files for consistency.\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: ref_file
    type:
      - 'null'
      - File
    doc: reference GenBank file
    inputBinding:
      position: 101
      prefix: --ref_file
  - id: test_file
    type: File
    doc: testing GenBank file
    inputBinding:
      position: 101
      prefix: --test_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_gbcheck.out
