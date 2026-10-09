cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - maq
  - submap
label: maq_submap
doc: "Extract a region from a map file\n\nTool homepage: http://maq.sourceforge.net/"
inputs:
  - id: out_map
    type: string
    doc: Output map file name
    inputBinding:
      position: 1
  - id: input_map
    type: File
    doc: Input map file
    inputBinding:
      position: 2
  - id: min_mapping_quality
    type:
      - 'null'
      - int
    doc: Minimum mapping quality
    inputBinding:
      position: 103
      prefix: -q
  - id: max_sum_errors
    type:
      - 'null'
      - int
    doc: Maximum sum of errors
    inputBinding:
      position: 103
      prefix: -Q
  - id: max_mismatches
    type:
      - 'null'
      - int
    doc: Maximum number of mismatches
    inputBinding:
      position: 103
      prefix: -m
  - id: correctly_paired_only
    type:
      - 'null'
      - boolean
    doc: Correctly paired reads only
    inputBinding:
      position: 103
      prefix: -p
outputs:
  - id: output_map
    type: File
    doc: Output map file
    outputBinding:
      glob: $(inputs.out_map)
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/maq:v0.7.1-8-deb_cv1
stdout: maq_submap.out
