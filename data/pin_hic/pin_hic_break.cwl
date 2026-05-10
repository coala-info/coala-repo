cwlVersion: v1.2
class: CommandLineTool
baseCommand: pin_hic
label: pin_hic_break
doc: "Identify breaks in a SAT file using Hi-C BAM files\n\nTool homepage: https://github.com/dfguan/pin_hic/"
inputs:
  - id: sat_file
    type: File
    doc: Input SAT file
    inputBinding:
      position: 1
  - id: bam_files
    type:
      type: array
      items: File
    doc: Input Hi-C BAM files
    inputBinding:
      position: 2
  - id: min_coverage_ratio
    type:
      - 'null'
      - float
    doc: minimum coverage ratio between maximum coverage and the gap coverage
    inputBinding:
      position: 103
      prefix: -m
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    inputBinding:
      position: 103
      prefix: -q
  - id: output_directory_path
    type:
      - 'null'
      - Directory
    doc: Output or path parameter `output_directory_path`
    inputBinding:
      position: 104
      prefix: --output-directory
  - id: output_prefix_path
    type:
      - 'null'
      - string
    doc: Output or path parameter `output_prefix_path`
    inputBinding:
      position: 105
      prefix: --output-prefix
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_directory_path)
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: output file prefix
    outputBinding:
      glob: $(inputs.output_prefix_path)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pin_hic:3.0.0--h577a1d6_5
