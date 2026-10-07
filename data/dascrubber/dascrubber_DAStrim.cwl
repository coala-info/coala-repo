cwlVersion: v1.2
class: CommandLineTool
baseCommand: DAStrim
label: dascrubber_DAStrim
doc: "DAStrim\n\nTool homepage: https://github.com/thegenemyers/DASCRUBBER"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.source_db)
        writable: true
inputs:
  - id: source_db
    type: File
    doc: Dazzler database (.db) of the whole read set. Its hidden .idx and .bps
      files and the .qual track made by DASqv must sit beside it. DAStrim adds
      new tracks beside the database.
    secondaryFiles:
      - "${ var d = self.location.replace(/[^\\/]+$/, ''); var r = self.nameroot;
        return ['idx', 'bps', 'qual.anno', 'qual.data'].map(function(x) { return
        {'class': 'File', 'location': d + '.' + r + '.' + x, 'basename': '.' + r
        + '.' + x}; }); }"
    inputBinding:
      position: 1
      valueFrom: $(self.basename)
  - id: overlaps_las
    type:
      type: array
      items: File
    doc: Sorted overlaps (.las) blocks made by daligner for this database
    inputBinding:
      position: 2
  - id: max_overlap_length
    type:
      - 'null'
      - int
    doc: Length threshold (-l, default 1000)
    inputBinding:
      position: 103
      prefix: -l
      separate: false
  - id: min_seed_coverage
    type: int
    doc: QV threshold for bad quality (-b)
    inputBinding:
      position: 103
      prefix: -b
      separate: false
  - id: min_seed_length
    type: int
    doc: QV threshold for good quality (-g)
    inputBinding:
      position: 103
      prefix: -g
      separate: false
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Print a report of breaks, trims and patches
    inputBinding:
      position: 103
      prefix: -v
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the -v report)
  - id: track_files
    type:
      type: array
      items: File
    doc: Tracks written beside the database (.anno and .data files of the
      trim, hq, keep, adapt, hole, span and split tracks)
    outputBinding:
      glob: |-
        ${ var r = '.' + inputs.source_db.nameroot + '.'; var g = [];
           ['trim', 'hq', 'keep', 'adapt', 'hole', 'span', 'split'].forEach(function(t) {
             g.push(r + t + '.anno'); g.push(r + t + '.data'); });
           return g; }
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dascrubber:v020160601-2-deb_cv1
stdout: dascrubber_DAStrim.out
