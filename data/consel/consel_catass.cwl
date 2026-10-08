cwlVersion: v1.2
class: CommandLineTool
baseCommand: catass
label: consel_catass
doc: "Join and manipulate association (ass) files (merge, extract, intersection, union, complement); writes <output_base>.ass. Without input files it writes the identity association of -m items.\n\nTool homepage: http://stat.sys.i.kyoto-u.ac.jp/prog/consel/"
inputs:
  - id: ass_files
    type:
      - 'null'
      - File[]
    doc: "input ass files"
    inputBinding:
      position: 2
  - id: output_base
    type: string
    doc: "base name of the output ass file, without extension"
    default: "catass_out"
    inputBinding:
      position: 3
  - id: max_items
    type:
      - 'null'
      - int
    doc: "number of items (for the identity association)"
    inputBinding:
      position: 1
      prefix: -m
  - id: extract_vt
    type:
      - 'null'
      - File
    doc: "vt file listing (0-based) the associations to extract"
    inputBinding:
      position: 1
      prefix: -x
  - id: extract_vt_ids
    type:
      - 'null'
      - File
    doc: "vt file listing (1-based ids) the associations to extract"
    inputBinding:
      position: 1
      prefix: -X
  - id: intersection
    type:
      - 'null'
      - boolean
    doc: "intersection"
    inputBinding:
      position: 1
      prefix: -i
  - id: union
    type:
      - 'null'
      - boolean
    doc: "union"
    inputBinding:
      position: 1
      prefix: -u
  - id: complement
    type:
      - 'null'
      - boolean
    doc: "complement (not)"
    inputBinding:
      position: 1
      prefix: -n
outputs:
  - id: ass
    type: File
    doc: "output association file"
    outputBinding:
      glob: $(inputs.output_base).ass
  - id: log
    type: stdout
    doc: program output and log
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/consel:0.20--h7b50bb2_3
stdout: consel_catass.log
