cwlVersion: v1.2
class: CommandLineTool
baseCommand: fmlrc-convert
label: fmlrc_convert
doc: "Convert a plain text BWT of short reads (for example from ropebwt2) into the
  compressed multi-string BWT format (.npy) used by fmlrc.\n\nTool homepage: https://github.com/holtjma/fmlrc"
inputs:
  - id: out_comp_msbwt_path
    type: string
    doc: Name of the compressed multi-string BWT (.npy) file to write
    inputBinding:
      position: 2
  - id: input_bwt
    type: File
    doc: The plain text BWT file to be converted into msbwt format
    inputBinding:
      position: 1
      prefix: -i
  - id: force
    type:
      - 'null'
      - boolean
    doc: Force overwrite of an existing file
    inputBinding:
      position: 0
      prefix: -f
outputs:
  - id: comp_msbwt
    type: File
    doc: Compressed multi-string BWT (.npy)
    outputBinding:
      glob: $(inputs.out_comp_msbwt_path)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fmlrc:1.0.0--h9948957_6
