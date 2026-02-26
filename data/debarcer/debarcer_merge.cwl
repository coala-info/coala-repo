cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - debarcer.py
  - merge
label: debarcer_merge
doc: "Merge files of a specified data type.\n\nTool homepage: https://github.com/oicr-gsi/debarcer"
inputs:
  - id: data_type
    type: string
    doc: Type of files to be merged
    inputBinding:
      position: 101
      prefix: --DataType
  - id: files
    type:
      type: array
      items: File
    doc: List of files to be merged
    inputBinding:
      position: 101
      prefix: --Files
  - id: output_dir
    type:
      - 'null'
      - Directory
    doc: Output directory where subdirectories are created
    inputBinding:
      position: 101
      prefix: --Outdir
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/debarcer:2.1.4--pyhdfd78af_2
stdout: debarcer_merge.out
