cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - fill_read_coverage
label: ra_fill_read_coverage
doc: "Computes the coverage of each read from the overlaps and stores it in the depot.\n\
  \nTool homepage: https://github.com/mariokostelac/ra"
inputs:
  - id: depot
    type: Directory
    doc: Depot directory (created by depot import_reads); it is updated in place
    inputBinding:
      position: 102
      prefix: --depot
      valueFrom: $(self.basename)
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
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ra:0.9--h503566f_8
