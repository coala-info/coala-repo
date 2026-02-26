cwlVersion: v1.2
class: CommandLineTool
baseCommand: mafToAxt
label: ucsc-maftoaxt
doc: "Convert MAF file to AXT file.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_maf
    type: File
    doc: Input MAF file
    inputBinding:
      position: 1
  - id: target_dir
    type: Directory
    doc: Directory containing target sequences (usually .2bit or .fa files)
    inputBinding:
      position: 2
  - id: query_dir
    type: Directory
    doc: Directory containing query sequences
    inputBinding:
      position: 3
  - id: bed_query
    type:
      - 'null'
      - File
    doc: Only include regions in this BED file for the query
    inputBinding:
      position: 104
      prefix: -bedQuery
  - id: bed_target
    type:
      - 'null'
      - File
    doc: Only include regions in this BED file for the target
    inputBinding:
      position: 104
      prefix: -bedTarget
  - id: strip_db
    type:
      - 'null'
      - boolean
    doc: Strip database name from sequence names
    inputBinding:
      position: 104
      prefix: -stripDb
outputs:
  - id: output_axt
    type: File
    doc: Output AXT file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-maftoaxt:482--h0b57e2e_0
