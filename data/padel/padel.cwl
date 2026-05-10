cwlVersion: v1.2
class: CommandLineTool
baseCommand: padeldescriptor
label: padel
doc: "PaDEL-Descriptor is a free software for the calculation of molecular descriptors
  and fingerprints.\n\nTool homepage: https://github.com/Joao-M-Silva/padel_analytics"
inputs:
  - id: input_file
    type: File
    doc: Input SDF file
    inputBinding:
      position: 1
  - id: descriptor_list
    type:
      - 'null'
      - type: array
        items: string
    doc: List of descriptors to calculate
    inputBinding:
      position: 102
      prefix: --descriptor
  - id: fingerprint_type
    type:
      - 'null'
      - string
    doc: Type of fingerprint to calculate (e.g., ECFP, MACCS)
    inputBinding:
      position: 102
      prefix: --fingerprint_type
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use
    inputBinding:
      position: 102
      prefix: --threads
  - id: fingerprint_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `fingerprint_file_path`
    inputBinding:
      position: 103
      prefix: --fingerprint-file
  - id: output_file_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_file_path`
    inputBinding:
      position: 104
      prefix: --output-file
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: Output descriptor file
    outputBinding:
      glob: $(inputs.output_file_path)
  - id: fingerprint_file
    type:
      - 'null'
      - File
    doc: Output fingerprint file
    outputBinding:
      glob: $(inputs.fingerprint_file_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/padel:2.21
