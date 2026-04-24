cwlVersion: v1.2
class: CommandLineTool
baseCommand: LinkStats
label: linkstats_LinkStats
doc: "Collect and process statistics from aligned linked-reads.\n\nTool homepage:
  https://github.com/wtsi-hpag/LinkStats"
inputs:
  - id: command1
    type: string
    doc: First command to execute
    inputBinding:
      position: 1
  - id: command1_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the first command
    inputBinding:
      position: 2
  - id: command2
    type:
      - 'null'
      - string
    doc: Second command to execute
    inputBinding:
      position: 3
  - id: command2_args
    type:
      - 'null'
      - type: array
        items: string
    doc: Arguments for the second command
    inputBinding:
      position: 4
  - id: min_reads
    type:
      - 'null'
      - type: array
        items: int
    doc: Minimum reads per molecule for analysis, multiple values possible.
      - 1
      - 3
      - 5
      - 10
    inputBinding:
      position: 105
      prefix: --min_reads
  - id: threads
    type:
      - 'null'
      - int
    doc: Number of threads to use.
    inputBinding:
      position: 105
      prefix: --threads
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/linkstats:0.1.3--py310h82d6cb0_6
stdout: linkstats_LinkStats.out
