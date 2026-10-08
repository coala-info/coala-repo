cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-label-adjacency
label: connectome-workbench_wb_command_cifti-label-adjacency
doc: "Find face-adjacent voxels and connected vertices that have different label values, and count them for each pair. Put the resulting counts into a parcellated connectivity file, with the diagonal being zero. This gives a rough estimate of how long or expansive the border between two labels is.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: label_in
    type: File
    doc: the input cifti label file
    inputBinding:
      position: 1
  - id: adjacency_out
    type: string
    doc: the output cifti pconn adjacency matrix
    inputBinding:
      position: 2
  - id: left_surface
    type:
      - 'null'
      - File
    doc: 'specify the left surface to use: the left surface file'
    inputBinding:
      position: 3
      prefix: -left-surface
  - id: right_surface
    type:
      - 'null'
      - File
    doc: 'specify the right surface to use: the right surface file'
    inputBinding:
      position: 4
      prefix: -right-surface
  - id: cerebellum_surface
    type:
      - 'null'
      - File
    doc: 'specify the cerebellum surface to use: the cerebellum surface file'
    inputBinding:
      position: 5
      prefix: -cerebellum-surface
outputs:
  - id: adjacency_out_file
    type: File
    doc: the output cifti pconn adjacency matrix
    outputBinding:
      glob: $(inputs.adjacency_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
