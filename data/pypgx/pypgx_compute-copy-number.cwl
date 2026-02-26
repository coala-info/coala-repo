cwlVersion: v1.2
class: CommandLineTool
baseCommand: pypgx compute-copy-number
label: pypgx_compute-copy-number
doc: "Compute copy number from read depth for target gene.\n\nTool homepage: https://github.com/sbslee/pypgx"
inputs:
  - id: read_depth
    type: File
    doc: Input archive file with the semantic type CovFrame[ReadDepth].
    inputBinding:
      position: 1
  - id: control_statistics
    type: File
    doc: Input archive file with the semantic type SampleTable[Statistics].
    inputBinding:
      position: 2
  - id: samples_without_sv
    type:
      - 'null'
      - type: array
        items: string
    doc: List of known samples with no SV.
    inputBinding:
      position: 103
      prefix: --samples-without-sv
outputs:
  - id: copy_number
    type: File
    doc: Output archive file with the semantic type CovFrame[CopyNumber].
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pypgx:0.26.0--pyh7e72e81_0
