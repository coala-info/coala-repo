cwlVersion: v1.2
class: CommandLineTool
baseCommand: cas-offinder
label: cas-offinder
doc: "Cas-OFFinder v2.4.1 (Jul 24 2025)\n\nTool homepage: https://github.com/snugel/cas-offinder"
inputs:
  - id: input_filename
    type: File
    doc: Input filename or '-' for stdin
    inputBinding:
      position: 1
  - id: device_type_and_ids
    type: string
    doc: Device type (C, G, A) and device ID(s)
    inputBinding:
      position: 2
outputs:
  - id: output_filename
    type: File
    doc: Output filename or '-' for stdout
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/cas-offinder:2.4.1--h503566f_0
