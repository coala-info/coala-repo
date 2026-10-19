cwlVersion: v1.2
class: CommandLineTool
baseCommand: cmsearchToBed
label: rnalien_cmsearchToBed
doc: "cmsearchToBED converts cmsearch file hits to BED file entries.\n\nTool homepage: https://github.com/eggzilla/RNAlien"
inputs:
  - id: cmsearch_path
    type: File
    doc: Path to input cmsearch file
    inputBinding:
      position: 101
      prefix: -i
  - id: browser_settings
    type:
      - 'null'
      - string
    doc: 'Browser settings. Default: browser hide all'
    inputBinding:
      position: 101
      prefix: -b
  - id: bed_visibility
    type:
      - 'null'
      - int
    doc: 'Visibility setting of track. Default: 2'
    inputBinding:
      position: 101
      prefix: -y
  - id: track_name
    type:
      - 'null'
      - string
    doc: 'Name of the track Default: PredictedRNA'
    inputBinding:
      position: 101
      prefix: -n
  - id: track_description
    type:
      - 'null'
      - string
    doc: 'Description of the track. Default: RNA loci predicted by cmsearch'
    inputBinding:
      position: 101
      prefix: -d
  - id: item_rgb
    type:
      - 'null'
      - boolean
    doc: 'RGB Color of the track. Default: True'
    inputBinding:
      position: 101
      prefix: -r
  - id: track_color
    type:
      - 'null'
      - string
    doc: 'RGB Color of the track. Default: 255,0,0'
    inputBinding:
      position: 101
      prefix: -c
  - id: sort_bed
    type:
      - 'null'
      - boolean
    doc: 'Sort entries of Bed file by start end end cooridinates. Default: True'
    inputBinding:
      position: 101
      prefix: -s
  - id: with_header
    type:
      - 'null'
      - boolean
    doc: 'Output contains bed header. Default: True'
    inputBinding:
      position: 101
      prefix: -w
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Loud verbosity
    inputBinding:
      position: 101
      prefix: --verbose
  - id: quiet
    type:
      - 'null'
      - boolean
    doc: Quiet verbosity
    inputBinding:
      position: 101
      prefix: --quiet
outputs:
  - id: bed
    type: stdout
    doc: BED entries (standard output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/rnalien:1.8.0--1
stdout: rnalien_cmsearchToBed.out
