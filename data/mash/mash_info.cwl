cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - mash
  - info
label: mash_info
doc: "Display information about sketch files.\n\nTool homepage: https://github.com/marbl/Mash"
inputs:
  - id: sketch
    type: File
    doc: Sketch file
    inputBinding:
      position: 1
  - id: dump_json
    type:
      - 'null'
      - boolean
    doc: Dump sketches in JSON format. Incompatible with -H, -t, and -c.
    inputBinding:
      position: 102
      prefix: -d
  - id: hash_count_histograms
    type:
      - 'null'
      - boolean
    doc: Show hash count histograms for each sketch. Incompatible with -d, -H 
      and -t.
    inputBinding:
      position: 102
      prefix: -c
  - id: header_only
    type:
      - 'null'
      - boolean
    doc: Only show header info. Do not list each sketch. Incompatible with -d, 
      -t and -c.
    inputBinding:
      position: 102
      prefix: -H
  - id: tabular_output
    type:
      - 'null'
      - boolean
    doc: Tabular output (rather than padded), with no header. Incompatible with 
      -d, -H and -c.
    inputBinding:
      position: 102
      prefix: -t
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mash:2.3--hb105d93_10
stdout: mash_info.out
