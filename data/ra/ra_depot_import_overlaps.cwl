cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - depot
  - import_overlaps
label: ra_depot_import_overlaps
doc: "Imports overlaps (MHAP or radump format) into a depot that already holds the\
  \ reads.\n\nTool homepage: https://github.com/mariokostelac/ra"
inputs:
  - id: depot
    type: Directory
    doc: Depot directory (created by depot import_reads); it is updated in place
    inputBinding:
      position: 102
      prefix: --depot
      valueFrom: $(self.basename)
  - id: overlaps
    type: File
    doc: 'overlaps file (staged writable: the mhap reader opens it read/write and
      crashes on a read-only file)'
    inputBinding:
      position: 102
      prefix: --overlaps
      valueFrom: $(self.basename)
  - id: overlaps_format
    type:
      - 'null'
      - string
    doc: 'overlaps format; supported: mhap, radump (default mhap)'
    inputBinding:
      position: 102
      prefix: --overlaps_format
outputs:
  - id: depot_out
    type: Directory
    doc: Updated depot directory
    outputBinding:
      glob: $(inputs.depot.basename)
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.depot)
        writable: true
      - entry: $(inputs.overlaps)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ra:0.9--h503566f_8
