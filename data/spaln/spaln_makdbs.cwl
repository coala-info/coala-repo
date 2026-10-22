cwlVersion: v1.2
class: CommandLineTool
baseCommand: makdbs
label: spaln_makdbs
doc: "makdbs: format a set of sequences to be quickly addressed (writes .ent, .grp, .idx, .odr and .seq files).\n\nTool homepage: https://github.com/ogotoh/spaln"
inputs:
  - id: ignore_ambiguity
    type:
      - 'null'
      - boolean
    doc: "Ignore abmiguity code"
    inputBinding:
      position: 10
      prefix: -a
      separate: false
  - id: include_comments
    type:
      - 'null'
      - boolean
    doc: "include comments/descriptions"
    inputBinding:
      position: 10
      prefix: -c
      separate: false
  - id: db_format
    type:
      - 'null'
      - string
    doc: "C = [e]mbl|[g]enbank|[n]brf|[p]rodb|[s]wiss (format of the source files)"
    inputBinding:
      position: 10
      prefix: -b
      separate: false
  - id: db_name
    type:
      - 'null'
      - string
    doc: "Body of file names to be created. If omitted, default name depending on DB type"
    inputBinding:
      position: 10
      prefix: -d
      separate: false
  - id: src_dir
    type:
      - 'null'
      - string
    doc: "Directory where source files are located (default: ., /usr/local/share/spaln/alndbs)"
    inputBinding:
      position: 10
      prefix: -s
      separate: false
  - id: dst_dir
    type:
      - 'null'
      - string
    doc: "Directory where destination files are located (default: current dir); must exist, so it is created by the wrapper"
    inputBinding:
      position: 10
      prefix: -p
      separate: false
  - id: seq_type
    type:
      - 'null'
      - string
    doc: "DNA or Protein sequence: D or P"
    inputBinding:
      position: 10
      prefix: -K
      separate: false
  - id: source_files
    type:
      type: array
      items: File
    doc: Source sequence files (multi-FASTA); staged into the working directory
    inputBinding:
      position: 200
      valueFrom: $(self.map(function(f){ return f.basename; }))
outputs:
  - id: db_files
    type:
      type: array
      items: File
    doc: Database files (.ent, .grp, .idx, .odr, .seq)
    outputBinding:
      glob: |-
        ${ var d = inputs.dst_dir ? inputs.dst_dir + '/' : ''; var n = inputs.db_name ? inputs.db_name : inputs.source_files[0].nameroot; return ['ent','grp','idx','odr','seq'].map(function(e){ return d + n + '.' + e; }); }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.source_files)
      - entryname: $(inputs.dst_dir || '.unused_dst_dir')
        entry: '$({class: "Directory", listing: []})'
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
