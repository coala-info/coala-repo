cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - DASqv
label: dascrubber_DASqv
doc: "Compute intrinsic quality values (QVs) for each read of a Dazzler database
  from its daligner overlaps and store them in a .qual track.\n\nTool homepage:
  https://github.com/thegenemyers/DASCRUBBER"
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.source_db)
        writable: true
inputs:
  - id: verbose
    type:
      - 'null'
      - boolean
    doc: Verbose mode (-v); print a histogram of the QVs
    inputBinding:
      position: 1
      prefix: -v
  - id: coverage
    type: int
    doc: Estimated coverage of the data set (-c<int>)
    inputBinding:
      position: 1
      prefix: -c
      separate: false
  - id: source_db
    type: File
    doc: Dazzler database (.db) of the read set. Its hidden .idx and .bps
      files must sit beside it. DASqv adds the .qual track beside the database.
    secondaryFiles:
      - "${ var d = self.location.replace(/[^\\/]+$/, ''); var r = self.nameroot;
        return ['idx', 'bps'].map(function(x) { return {'class': 'File',
        'location': d + '.' + r + '.' + x, 'basename': '.' + r + '.' + x}; }); }"
    inputBinding:
      position: 2
      valueFrom: $(self.basename)
  - id: overlaps_las
    type:
      type: array
      items: File
    doc: Sorted overlaps (.las) blocks made by daligner for this database
    inputBinding:
      position: 3
outputs:
  - id: stdout
    type: stdout
    doc: Standard output (the -v report)
  - id: qual_track
    type:
      type: array
      items: File
    doc: The .qual track written beside the database (.qual.anno and .qual.data)
    outputBinding:
      glob: |-
        ${ var r = '.' + inputs.source_db.nameroot + '.qual.'; return [r + 'anno', r + 'data']; }
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/dascrubber:v020160601-2-deb_cv1
stdout: dascrubber_DASqv.out
