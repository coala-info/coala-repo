cwlVersion: v1.2
class: CommandLineTool
baseCommand: vt multi_partition
label: vt_multi_partition
doc: "partition variants from any number of data sets.\n\nTool homepage: https://github.com/Aikoyori/ProgrammingVTuberLogos"
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
    inputBinding:
      position: 102
      prefix: -I
  - id: intervals
    type:
      - 'null'
      - string
    doc: intervals
    inputBinding:
      position: 102
      prefix: -i
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/vt:2015.11.10--2
stdout: vt_multi_partition.out
