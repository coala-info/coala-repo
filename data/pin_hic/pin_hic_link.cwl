cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - pin_hic
  - link
label: pin_hic_link
doc: "Collect Hi-C links from BAM files\n\nTool homepage: https://github.com/dfguan/pin_hic/"
inputs:
  - id: bam_file
    type: File
    doc: Input BAM file
    inputBinding:
      position: 1
  - id: collect_all
    type:
      - 'null'
      - boolean
    doc: collect all contacts
    default: false
    inputBinding:
      position: 102
      prefix: -a
  - id: min_alignment_quality
    type:
      - 'null'
      - int
    doc: minimum alignment quality
    default: 10
    inputBinding:
      position: 102
      prefix: -q
  - id: sat_file
    type:
      - 'null'
      - File
    doc: sat file
    inputBinding:
      position: 102
      prefix: -s
  - id: use_middle
    type:
      - 'null'
      - boolean
    doc: use middle
    default: false
    inputBinding:
      position: 102
      prefix: -g
  - id: use_min_dist
    type:
      - 'null'
      - boolean
    doc: use minimum dist to normalize weight
    default: false
    inputBinding:
      position: 102
      prefix: -d
outputs:
  - id: output_file
    type:
      - 'null'
      - File
    doc: output file
    outputBinding:
      glob: $(inputs.output_file)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pin_hic:3.0.0--h577a1d6_5
