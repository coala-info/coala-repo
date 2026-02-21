cwlVersion: v1.2
class: CommandLineTool
baseCommand: axtToMaf
label: ucsc-axttomaf
doc: "Convert from axt to maf format. axtToMaf combines axt alignment files with sequence
  size information to produce MAF (Multiple Alignment Format) files.\n\nTool homepage:
  https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: axt_file
    type: File
    doc: Input axt file
    inputBinding:
      position: 1
  - id: t_size_file
    type: File
    doc: 'Target sequence size file (two-column file: name and size)'
    inputBinding:
      position: 2
  - id: q_size_file
    type: File
    doc: 'Query sequence size file (two-column file: name and size)'
    inputBinding:
      position: 3
  - id: q_name
    type:
      - 'null'
      - string
    doc: Use specified name as the query name in the maf file
    inputBinding:
      position: 104
      prefix: -qName
  - id: t_name
    type:
      - 'null'
      - string
    doc: Use specified name as the target name in the maf file
    inputBinding:
      position: 104
      prefix: -tName
outputs:
  - id: maf_file
    type: File
    doc: Output maf file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-axttomaf:482--h0b57e2e_0
