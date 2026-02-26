cwlVersion: v1.2
class: CommandLineTool
baseCommand: twoBitMask
label: ucsc-twobitmask_twoBitMask
doc: "apply masking to a .2bit file, creating a new .2bit file\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: input .2bit file
    inputBinding:
      position: 1
  - id: mask_file
    type: File
    doc: maskFile can be a RepeatMasker .out file or a .bed file. It must not 
      contain rows for sequences which are not in input.2bit.
    inputBinding:
      position: 2
  - id: add
    type:
      - 'null'
      - boolean
    doc: Don't remove pre-existing masking before applying maskFile.
    inputBinding:
      position: 103
      prefix: -add
  - id: type
    type:
      - 'null'
      - string
    doc: Type of maskFile is XXX (bed or out).
    inputBinding:
      position: 103
      prefix: -type
outputs:
  - id: output_file
    type: File
    doc: output .2bit file
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-twobitmask:482--h0b57e2e_0
