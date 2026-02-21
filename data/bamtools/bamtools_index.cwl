cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - bamtools
  - index
label: bamtools_index
doc: "creates index for BAM file.\n\nTool homepage: https://github.com/pezmaster31/bamtools"
inputs:
  - id: create_bti
    type:
      - 'null'
      - boolean
    doc: create (non-standard) BamTools index file (*.bti). Default behavior is to
      create standard BAM index (*.bai)
    inputBinding:
      position: 101
      prefix: -bti
  - id: input_file
    type:
      - 'null'
      - File
    doc: the input BAM file [stdin]
    inputBinding:
      position: 101
      prefix: -in
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/bamtools:2.5.3--he132191_0
stdout: bamtools_index.out
