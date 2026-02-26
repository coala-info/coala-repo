cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt partition
label: vt_partition
doc: "partition variants from two data sets.\n\nTool homepage: https://github.com/Aikoyori/ProgrammingVTuberLogos"
inputs:
  - id: input_vcfs
    type:
      type: array
      items: File
    doc: Input VCF files
    inputBinding:
      position: 1
  - id: filter
    type:
      - 'null'
      - boolean
    doc: filter
    inputBinding:
      position: 102
      prefix: -f
  - id: interval_list_file
    type:
      - 'null'
      - File
    doc: file containing list of intervals
    default: '[]'
    inputBinding:
      position: 102
      prefix: -I
  - id: intervals
    type:
      - 'null'
      - string
    doc: intervals
    default: '[]'
    inputBinding:
      position: 102
      prefix: -i
  - id: write_partitioned_variants_to_file
    type:
      - 'null'
      - boolean
    doc: write partitioned variants to file
    inputBinding:
      position: 102
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
stdout: vt_partition.out
