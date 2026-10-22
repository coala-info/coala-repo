cwlVersion: v1.2
class: CommandLineTool
baseCommand: makblk.pl
label: spaln_makblk.pl
doc: "makblk.pl: write block information (index) for spaln from sequence files or an x.grp database made by makdbs.\n\nTool homepage: https://github.com/ogotoh/spaln"
inputs:
  - id: block_file
    type:
      - 'null'
      - string
    doc: "Name of the block information file to write, e.g. x.bkn, x.bkp or x.bka (glued to -W)"
    inputBinding:
      position: 10
      prefix: -W
      separate: false
  - id: seq_type
    type:
      - 'null'
      - string
    doc: "Sequence type: D (genomic DNA), P (genomic DNA for protein queries) or S (see makblk.pl); glued to -K"
    inputBinding:
      position: 10
      prefix: -K
      separate: false
  - id: reduced_alphabet
    type:
      - 'null'
      - boolean
    doc: "use reduced alphabet"
    inputBinding:
      position: 10
      prefix: -r
      separate: false
  - id: spaln_options
    type:
      - 'null'
      - type: array
        items: string
    doc: "Extra options transferred to spaln, each written in full with its -X prefix, e.g. -Xk6 or -XC1"
    inputBinding:
      position: 11
  - id: targets
    type:
      type: array
      items: File
    doc: Sequence files (seq.1 seq.2 ...) or the x.grp file of a database made with makdbs; staged into the working directory
    inputBinding:
      position: 200
      valueFrom: $(self.map(function(f){ return f.basename; }))
  - id: db_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Companion files of the x.grp database (.ent, .idx, .seq, and the source sequence file named in the .grp file), staged into the working directory
outputs:
  - id: block_files
    type:
      type: array
      items: File
    doc: Block information file and database files written by makblk.pl
    outputBinding:
      glob: |-
        ${ var b = inputs.block_file ? inputs.block_file.replace(/\.[^.\/]*$/, '') : inputs.targets[0].nameroot; return [b + '.bk*', b + '.ent', b + '.grp', b + '.idx', b + '.odr', b + '.seq']; }
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.targets)
      - $(inputs.db_files || [])
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/spaln:3.0.7--pl5321h077b44d_1
