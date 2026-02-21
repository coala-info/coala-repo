cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panchip
  - filter
label: panchip_filter
doc: "Filtering library for quality control\n\nTool homepage: https://github.com/hanjunlee21/PanChIP"
inputs:
  - id: library_directory
    type: Directory
    doc: Directory wherein PanChIP library was stored.
    inputBinding:
      position: 1
  - id: input_file
    type: File
    doc: Path to the input .bed file.
    inputBinding:
      position: 2
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    default: 1
    inputBinding:
      position: 103
      prefix: -t
outputs:
  - id: output_directory
    type: Directory
    doc: Output directory wherein output files will be stored.
    outputBinding:
      glob: '*.out'
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/panchip:3.0.14--py312h7e72e81_0
