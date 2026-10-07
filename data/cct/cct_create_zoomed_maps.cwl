cwlVersion: v1.2
class: CommandLineTool
baseCommand: create_zoomed_maps
label: cct_create_zoomed_maps
doc: "Creates a zoomed map for completed CCT project.\n\nTool homepage: https://github.com/paulstothard/cgview_comparison_tool"
inputs:
  - id: project
    type: Directory
    doc: Path to a completed CCT project.
    inputBinding:
      position: 1
      prefix: -p
      valueFrom: $(self.basename)
  - id: center
    type: int
    doc: Nucleotide position to center the zoomed map on.
    inputBinding:
      position: 2
      prefix: -c
  - id: zoom
    type: int
    doc: Zoom multiplier.
    inputBinding:
      position: 2
      prefix: -z
  - id: format
    type:
      - 'null'
      - string
    doc: "Image format for output map. Options are png, jpg, svg, svgz.  (Default: png)"
    inputBinding:
      position: 2
      prefix: -f
  - id: memory
    type:
      - 'null'
      - string
    doc: "Memory value for Java's -Xmx option (Default: 1500m)."
    inputBinding:
      position: 2
      prefix: -m
outputs:
  - id: project_dir
    type: Directory
    doc: Project directory with the zoomed maps
    outputBinding:
      glob: $(inputs.project.basename)
requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entry: $(inputs.project)
        writable: true
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/cct:v20170919dfsg-1-deb_cv1
