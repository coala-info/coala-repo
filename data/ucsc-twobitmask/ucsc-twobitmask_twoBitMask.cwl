cwlVersion: v1.2
class: CommandLineTool
baseCommand: twoBitMask
label: ucsc-twobitmask_twoBitMask
doc: "Apply masking to a .2bit file, creating a new .2bit file. The mask file can be
  a RepeatMasker .out file or a .bed file. It must not contain rows for sequences which
  are not in input.2bit.\n\nTool homepage: https://hgdownload.cse.ucsc.edu/admin/exe"
inputs:
  - id: input_file
    type: File
    doc: Input .2bit file.
    inputBinding:
      position: 1
  - id: mask_file
    type: File
    doc: Mask file; a RepeatMasker .out file or a .bed file.
    inputBinding:
      position: 2
  - id: output_file
    type: string
    doc: Output .2bit file name.
    inputBinding:
      position: 3
  - id: add
    type:
      - 'null'
      - boolean
    doc: Do not remove pre-existing masking before applying maskFile.
    inputBinding:
      position: 1
      prefix: -add
  - id: type
    type:
      - 'null'
      - string
    doc: Type of maskFile is XXX (.bed or .out); for example .bed
    inputBinding:
      position: 1
      prefix: -type=
      separate: false
outputs:
  - id: out_output_file
    type: File
    doc: Output .2bit file.
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ucsc-twobitmask:482--h0b57e2e_0
