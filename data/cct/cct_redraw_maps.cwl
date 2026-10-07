cwlVersion: v1.2
class: CommandLineTool
baseCommand: redraw_maps
label: cct_redraw_maps
doc: "Used to redraw the maps. This can be used after editing the CGView XML file or
  to change the output image formats.\n\nTool homepage: https://github.com/paulstothard/cgview_comparison_tool"
inputs:
  - id: project
    type: Directory
    doc: Path to a completed CCT project.
    inputBinding:
      position: 1
      prefix: -p
      valueFrom: $(self.basename)
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
    doc: Project directory with the redrawn maps
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
