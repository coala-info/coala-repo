cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cpstools
  - RSCU
label: cpstools_RSCU
doc: "Calculate RSCU values for CDS sequences.\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: filter_length
    type:
      - 'null'
      - int
    doc: CDS filter length
    inputBinding:
      position: 101
      prefix: --filter_length
  - id: work_dir
    type: Directory
    doc: Input directory of genbank files
    inputBinding:
      position: 101
      prefix: --work_dir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_RSCU.out
