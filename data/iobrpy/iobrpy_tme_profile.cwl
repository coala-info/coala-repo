cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - iobrpy
  - tme_profile
label: iobrpy_tme_profile
doc: "TPM matrix (genes x samples). CSV/TSV/.gz supported.\n\nTool homepage: https://github.com/IOBR/IOBRpy"
inputs:
  - id: input
    type: File
    doc: TPM matrix (genes x samples). CSV/TSV/.gz supported.
    inputBinding:
      position: 101
      prefix: --input
  - id: threads
    type:
      - 'null'
      - int
    doc: Threads for ssGSEA and CIBERSORT
    inputBinding:
      position: 101
      prefix: --threads
outputs:
  - id: output
    type: Directory
    doc: Output directory (01-signatures, 02-tme, 03-LR_cal).
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/iobrpy:0.1.7--pyhdfd78af_0
