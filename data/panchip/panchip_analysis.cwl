cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - panchip
  - analysis
label: panchip_analysis
doc: "Analysis of a list peak sets\n\nTool homepage: https://github.com/hanjunlee21/PanChIP"
inputs:
  - id: library_directory
    type: Directory
    doc: Directory wherein PanChIP library was stored.
    inputBinding:
      position: 1
  - id: input_directory
    type: Directory
    doc: Input directory wherein peak sets in the format of .bed files are located.
    inputBinding:
      position: 2
  - id: repeats
    type:
      - 'null'
      - int
    doc: Number of repeats to perform.
    default: 1
    inputBinding:
      position: 103
      prefix: -r
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
