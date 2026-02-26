cwlVersion: v1.2
class: CommandLineTool
baseCommand: ropebwt3_stat
label: ropebwt3_stat
doc: "Compute statistics for an FMD-index.\n\nTool homepage: https://github.com/lh3/ropebwt3"
inputs:
  - id: idx_fmd
    type: File
    doc: The FMD-index file.
    inputBinding:
      position: 1
  - id: max_matches
    type:
      - 'null'
      - boolean
    doc: Compute the maximum number of matches for each position.
    inputBinding:
      position: 102
      prefix: -M
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ropebwt3:3.10--h577a1d6_0
stdout: ropebwt3_stat.out
