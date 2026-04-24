cwlVersion: v1.2
class: CommandLineTool
baseCommand: pslPartition
label: ucsc-pslpartition
doc: "Split a PSL file into smaller files based on record counts or other criteria.\n\
  \nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: psl_file
    type: File
    doc: The input PSL file to be partitioned.
    inputBinding:
      position: 1
  - id: drop_unmapped
    type:
      - 'null'
      - boolean
    doc: Drop unmapped records from the output.
    inputBinding:
      position: 102
      prefix: -dropUnmapped
  - id: part_size
    type:
      - 'null'
      - int
    doc: Number of records per partition.
    inputBinding:
      position: 102
      prefix: -partSize
outputs:
  - id: out_dir
    type: Directory
    doc: The output directory where partitioned PSL files will be written.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-pslpartition:482--h0b57e2e_0
