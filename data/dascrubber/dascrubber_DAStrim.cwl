cwlVersion: v1.2
class: CommandLineTool
baseCommand: DAStrim
label: dascrubber_DAStrim
doc: "DAStrim\n\nTool homepage: https://github.com/thegenemyers/DASCRUBBER"
inputs:
  - id: source_db
    type: File
    doc: Source database file
    inputBinding:
      position: 1
  - id: overlaps_las
    type:
      type: array
      items: File
    doc: Overlaps LAS files
    inputBinding:
      position: 2
  - id: max_overlap_length
    type:
      - 'null'
      - int
    doc: Maximum overlap length
    default: 1000
    inputBinding:
      position: 103
      prefix: -l
  - id: min_seed_coverage
    type: int
    doc: Minimum seed coverage
    inputBinding:
      position: 103
      prefix: -b
  - id: min_seed_length
    type: int
    doc: Minimum seed length
    inputBinding:
      position: 103
      prefix: -g
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Enable verbose output
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dascrubber:v020160601-2-deb_cv1
stdout: dascrubber_DAStrim.out
