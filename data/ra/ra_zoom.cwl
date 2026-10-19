cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - zoom
label: ra_zoom
doc: "Zooms into a part of the overlap graph: depth-limited search from a root read;\
  \ the overlaps found are written to standard output.\n\nTool homepage: https://github.com/mariokostelac/ra"
inputs:
  - id: depot
    type: Directory
    doc: Depot directory (created by depot import_reads); it is updated in place
    inputBinding:
      position: 102
      prefix: --depot
      valueFrom: $(self.basename)
  - id: root
    type: int
    doc: root read
    inputBinding:
      position: 102
      prefix: --root
  - id: depth
    type: int
    doc: neighborhood depth
    inputBinding:
      position: 102
      prefix: --depth
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.depot)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/ra:0.9--h503566f_8
stdout: ra_zoom.out
