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
    default: 0.3
    inputBinding:
      position: 103
      prefix: -m
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    default: 10
    inputBinding:
      position: 103
      prefix: -q
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_directory)
  - id: output_prefix
    type:
      - 'null'
      - File
    doc: output file prefix
    outputBinding:
      glob: $(inputs.output_prefix)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pin_hic:3.0.0--h577a1d6_5
