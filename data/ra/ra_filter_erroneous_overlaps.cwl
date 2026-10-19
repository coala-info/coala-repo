cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - filter_erroneous_overlaps
label: ra_filter_erroneous_overlaps
doc: "Removes erroneous overlaps (high error rate or low covered length) from the\
  \ depot and writes the used spec file.\n\nTool homepage: https://github.com/mariokostelac/ra"
inputs:
  - id: depot
    type: Directory
    doc: Depot directory (created by depot import_reads); it is updated in place
    inputBinding:
      position: 102
      prefix: --depot
      valueFrom: $(self.basename)
  - id: spec_file
    type:
      - 'null'
      - File
    doc: spec file path
    inputBinding:
      position: 102
      prefix: --spec_file
  - id: working_directory
    type:
      - 'null'
      - string
    doc: working directory (default .); the spec file is written there
    inputBinding:
      position: 102
      prefix: --working_directory
outputs:
  - id: depot_out
    type: Directory
    doc: Updated depot directory
    outputBinding:
      glob: $(inputs.depot.basename)
  - id: spec_out
    type:
      - 'null'
      - File
    doc: Spec file with the used settings
    outputBinding:
      glob: $(inputs.working_directory || '.')/filter_erroneous_overlaps.spec
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.depot)
        writable: true
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ra:0.9--h503566f_8
