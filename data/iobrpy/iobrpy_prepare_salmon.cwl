cwlVersion: v1.2
class: CommandLineTool
baseCommand: iobrpy_prepare_salmon
label: iobrpy_prepare_salmon
doc: "Prepare a TPM matrix from Salmon output.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: input_eset_path
    type: File
    doc: Path to input Salmon file (TSV or TSV.GZ)
    inputBinding:
      position: 101
      prefix: --input
  - id: remove_version
    type:
      - 'null'
      - boolean
    doc: Remove version suffix from gene IDs
    inputBinding:
      position: 101
      prefix: --remove_version
  - id: return_feature
    type:
      - 'null'
      - string
    doc: Which gene feature to retain
    inputBinding:
      position: 101
      prefix: --return_feature
outputs:
  - id: output_matrix
    type: File
    doc: Path to save cleaned TPM matrix
    outputBinding:
      glob: $(inputs.output_matrix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
