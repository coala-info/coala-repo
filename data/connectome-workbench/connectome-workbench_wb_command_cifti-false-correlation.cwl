cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-false-correlation
label: connectome-workbench_wb_command_cifti-false-correlation
doc: "For each vertex, compute the average correlation within a range of geodesic distances that don't cross a sulcus/gyrus, and the correlation to the closest vertex crossing a sulcus/gyrus. A vertex is considered to cross a sulcus/gyrus if the 3D distance is less than a third of the geodesic distance. The output file contains the ratio between these correlations, and some additional maps to help explain the ratio.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_in
    type: File
    doc: the cifti file to use for correlation
    inputBinding:
      position: 1
  - id: dist_3d
    type: float
    doc: maximum 3D distance to check around each vertex
    inputBinding:
      position: 2
  - id: geo_outer
    type: float
    doc: maximum geodesic distance to use for neighboring correlation
    inputBinding:
      position: 3
  - id: geo_inner
    type: float
    doc: minimum geodesic distance to use for neighboring correlation
    inputBinding:
      position: 4
  - id: cifti_out
    type: string
    doc: the output cifti dscalar file
    inputBinding:
      position: 5
  - id: left_surface
    type:
      - 'null'
      - File
    doc: 'specify the left surface to use: the left surface file'
    inputBinding:
      position: 6
      prefix: -left-surface
  - id: dump_text
    type:
      - 'null'
      - string
    doc: 'dump the raw measures used to a text file: the output text file (use with -left-surface)'
    inputBinding:
      position: 7
      prefix: -dump-text
  - id: right_surface
    type:
      - 'null'
      - File
    doc: 'specify the right surface to use: the right surface file'
    inputBinding:
      position: 8
      prefix: -right-surface
  - id: right_surface_dump_text
    type:
      - 'null'
      - string
    doc: 'dump the raw measures used to a text file: the output text file (use with -right-surface)'
    inputBinding:
      position: 9
      prefix: -dump-text
  - id: cerebellum_surface
    type:
      - 'null'
      - File
    doc: 'specify the cerebellum surface to use: the cerebellum surface file'
    inputBinding:
      position: 10
      prefix: -cerebellum-surface
  - id: cerebellum_surface_dump_text
    type:
      - 'null'
      - string
    doc: 'dump the raw measures used to a text file: the output text file (use with -cerebellum-surface)'
    inputBinding:
      position: 11
      prefix: -dump-text
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti dscalar file
    outputBinding:
      glob: $(inputs.cifti_out)
  - id: dump_text_file
    type:
      - 'null'
      - File
    doc: the output text file
    outputBinding:
      glob: $(inputs.dump_text)
  - id: right_surface_dump_text_file
    type:
      - 'null'
      - File
    doc: the output text file
    outputBinding:
      glob: $(inputs.right_surface_dump_text)
  - id: cerebellum_surface_dump_text_file
    type:
      - 'null'
      - File
    doc: the output text file
    outputBinding:
      glob: $(inputs.cerebellum_surface_dump_text)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
