cwlVersion: v1.2
class: CommandLineTool
baseCommand: pin_hic_it
label: pin_hic_pin_hic_it
doc: "A tool for Hi-C based scaffolding of genomic contigs.\n\nTool homepage: https://github.com/dfguan/pin_hic/"
inputs:
  - id: bam_files
    type:
      type: array
      items: File
    doc: Input BAM file(s)
    inputBinding:
      position: 1
  - id: accurate_mode
    type:
      - 'null'
      - boolean
    doc: accurate mode
    inputBinding:
      position: 102
      prefix: -a
  - id: candidate_number
    type:
      - 'null'
      - int
    doc: candidate number
    inputBinding:
      position: 102
      prefix: -c
  - id: edge_weight_unnormalized
    type:
      - 'null'
      - boolean
    doc: use unnormalized weight as edge weight
    inputBinding:
      position: 102
      prefix: -e
  - id: iteration_times
    type:
      - 'null'
      - int
    doc: iteration times
    inputBinding:
      position: 102
      prefix: -i
  - id: min_contact_number
    type:
      - 'null'
      - int
    doc: minimum contact number
    inputBinding:
      position: 102
      prefix: -w
  - id: min_coverage_ratio
    type:
      - 'null'
      - float
    doc: minimum coverage ratio between maximu coverage and the gap coverage
    inputBinding:
      position: 102
      prefix: -m
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: minimum mapping quality
    inputBinding:
      position: 102
      prefix: -q
  - id: min_orientation_diff
    type:
      - 'null'
      - float
    doc: minimum difference between best and secondary orientation
    inputBinding:
      position: 102
      prefix: -d
  - id: min_scaffold_length
    type:
      - 'null'
      - int
    doc: minimum scaffold length
    inputBinding:
      position: 102
      prefix: -l
  - id: no_break
    type:
      - 'null'
      - boolean
    doc: do not break at the final step
    inputBinding:
      position: 102
      prefix: -b
  - id: reference_fa_index
    type:
      - 'null'
      - File
    doc: reference fa index file
    inputBinding:
      position: 102
      prefix: -x
  - id: reference_file
    type:
      - 'null'
      - File
    doc: reference file
    inputBinding:
      position: 102
      prefix: -r
  - id: sat_file
    type:
      - 'null'
      - File
    doc: sat file
    inputBinding:
      position: 102
      prefix: -s
  - id: unnormalized_weight
    type:
      - 'null'
      - boolean
    doc: use unnormalized weight
    inputBinding:
      position: 102
      prefix: -n
  - id: use_middle_part
    type:
      - 'null'
      - boolean
    doc: use middle part of contigs
    inputBinding:
      position: 102
      prefix: -g
  - id: use_mst
    type:
      - 'null'
      - boolean
    doc: use MST for scaffolding
    inputBinding:
      position: 102
      prefix: '-1'
  - id: use_product
    type:
      - 'null'
      - boolean
    doc: use product
    inputBinding:
      position: 102
      prefix: -p
outputs:
  - id: output_directory
    type:
      - 'null'
      - Directory
    doc: output directory
    outputBinding:
      glob: $(inputs.output_directory)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/pin_hic:3.0.0--h577a1d6_5
