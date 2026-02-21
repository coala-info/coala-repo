cwlVersion: v1.2
class: CommandLineTool
baseCommand: bigBedNamedItems
label: ucsc-bigbednameditems
doc: "Extract items from bigBed that match a list of names.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: big_bed
    type: File
    doc: The input bigBed file.
    inputBinding:
      position: 1
  - id: names
    type: string
    doc: Either a single name or a file with one name per line (if -nameFile is used).
    inputBinding:
      position: 2
  - id: name_file
    type:
      - 'null'
      - boolean
    doc: If set, the names argument is treated as a file with one name per line.
    inputBinding:
      position: 103
      prefix: -nameFile
outputs:
  - id: output
    type: File
    doc: The output bed file.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-bigbednameditems:482--h0b57e2e_0
