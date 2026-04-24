cwlVersion: v1.2
class: CommandLineTool
baseCommand: fermi2 assemble
label: fermi2_assemble
doc: "Assemble reads into contigs\n\nTool homepage: https://github.com/lh3/fermi2"
inputs:
  - id: reads_rld
    type: File
    doc: Input reads file in RLD format
    inputBinding:
      position: 1
  - id: min_match
    type:
      - 'null'
      - int
    doc: min match
    inputBinding:
      position: 102
      prefix: -l
  - id: min_merge_length
    type:
      - 'null'
      - int
    doc: min merge length
    inputBinding:
      position: 102
      prefix: -m
  - id: threads
    type:
      - 'null'
      - int
    doc: number of threads
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fermi2:r193--h577a1d6_10
stdout: fermi2_assemble.out
