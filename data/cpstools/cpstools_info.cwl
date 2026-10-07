cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - cpstools
  - info
label: cpstools_info
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.input_file)
        writable: true
doc: "Show information about a genbank file.\n\nTool homepage: https://github.com/Xwb7533/CPStools"
inputs:
  - id: input_file
    type: File
    doc: Input genbank format file
    inputBinding:
      position: 101
      prefix: --input_file
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (intron statistics)
  - id: info_table
    type: File
    doc: Gene type statistics table written beside the input file
    outputBinding:
      glob: '*.tsv'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cpstools:3.0--pyhdfd78af_0
stdout: cpstools_info.out
