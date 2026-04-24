cwlVersion: v1.2
class: CommandLineTool
baseCommand: DBshow
label: dazz_db_DBshow
doc: "Show information about a dazzle database or dam file.\n\nTool homepage: https://github.com/thegenemyers/DAZZ_DB"
inputs:
  - id: db_or_dam_path
    type: Directory
    doc: Path to the dazzle database or dam file.
    inputBinding:
      position: 1
  - id: reads
    type:
      - 'null'
      - type: array
        items: string
    doc: Reads file or range to process.
    inputBinding:
      position: 2
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet mode.
    inputBinding:
      position: 103
      prefix: -q
  - id: show_all_tracks
    type:
      - 'null'
      - boolean
    doc: Show all tracks.
    inputBinding:
      position: 103
      prefix: -U
  - id: show_unique_tracks
    type:
      - 'null'
      - boolean
    doc: Show unique tracks.
    inputBinding:
      position: 103
      prefix: -Q
  - id: tracks
    type:
      - 'null'
      - type: array
        items: string
    doc: Specify tracks to show.
    inputBinding:
      position: 103
      prefix: -m
  - id: unq
    type:
      - 'null'
      - boolean
    doc: Show unique k-mers only.
    inputBinding:
      position: 103
      prefix: -u
  - id: unq_all
    type:
      - 'null'
      - boolean
    doc: Show unique k-mers from all tracks.
    inputBinding:
      position: 103
      prefix: -n
  - id: width
    type:
      - 'null'
      - int
    doc: Set output width.
    inputBinding:
      position: 103
      prefix: -w
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/dazz_db:1.0--0
stdout: dazz_db_DBshow.out
