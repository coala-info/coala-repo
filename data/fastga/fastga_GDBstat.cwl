cwlVersion: v1.2
class: CommandLineTool
baseCommand: GDBstat
label: fastga_GDBstat
doc: "Display histograms of scaffold & contig lengths.\n\nTool homepage: https://github.com/thegenemyers/FASTGA"
inputs:
  - id: source_path
    type: string
    doc: Source GDB path
    inputBinding:
      position: 1
  - id: display_histograms
    type:
      - 'null'
      - boolean
    doc: Display histograms of scaffold & contig lengths.
    inputBinding:
      position: 102
      prefix: -h
  - id: histogram_bucket_sizes
    type:
      - 'null'
      - type: array
        items: int
    doc: Bucket sizes for respective histograms
    inputBinding:
      position: 102
      prefix: -h
  - id: log_histograms
    type:
      - 'null'
      - boolean
    doc: Log histograms
    inputBinding:
      position: 102
      prefix: -hlog
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/fastga:1.3.1--h577a1d6_0
stdout: fastga_GDBstat.out
