cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-gradient
label: connectome-workbench_wb_command_cifti-gradient
doc: "Performs gradient calculation on each component of the cifti file, and optionally averages the resulting gradients. The -vectors and -average-output options may not be used together. You must specify a surface for each surface structure in the cifti file. The COLUMN direction should be faster, and is the direction that works on dtseries. For dconn, you probably want ROW, unless you are using -average-output.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti
    type: File
    doc: the input cifti
    inputBinding:
      position: 1
  - id: direction
    type: string
    doc: which dimension to take the gradient along, ROW or COLUMN
    inputBinding:
      position: 2
  - id: cifti_out
    type: string
    doc: the output cifti
    inputBinding:
      position: 3
  - id: left_surface
    type:
      - 'null'
      - File
    doc: 'specify the left surface to use: the left surface file'
    inputBinding:
      position: 4
      prefix: -left-surface
  - id: left_corrected_areas
    type:
      - 'null'
      - File
    doc: 'vertex areas to use instead of computing them from the left surface: the corrected vertex areas, as a metric (use with -left-surface)'
    inputBinding:
      position: 5
      prefix: -left-corrected-areas
  - id: right_surface
    type:
      - 'null'
      - File
    doc: 'specify the right surface to use: the right surface file'
    inputBinding:
      position: 6
      prefix: -right-surface
  - id: right_corrected_areas
    type:
      - 'null'
      - File
    doc: 'vertex areas to use instead of computing them from the right surface: the corrected vertex areas, as a metric (use with -right-surface)'
    inputBinding:
      position: 7
      prefix: -right-corrected-areas
  - id: cerebellum_surface
    type:
      - 'null'
      - File
    doc: 'specify the cerebellum surface to use: the cerebellum surface file'
    inputBinding:
      position: 8
      prefix: -cerebellum-surface
  - id: cerebellum_corrected_areas
    type:
      - 'null'
      - File
    doc: 'vertex areas to use instead of computing them from the cerebellum surface: the corrected vertex areas, as a metric (use with -cerebellum-surface)'
    inputBinding:
      position: 9
      prefix: -cerebellum-corrected-areas
  - id: surface_presmooth
    type:
      - 'null'
      - float
    doc: 'smooth on the surface before computing the gradient: the sigma for the gaussian surface smoothing kernel, in mm'
    inputBinding:
      position: 10
      prefix: -surface-presmooth
  - id: volume_presmooth
    type:
      - 'null'
      - float
    doc: 'smooth on the surface before computing the gradient: the sigma for the gaussian volume smoothing kernel, in mm'
    inputBinding:
      position: 11
      prefix: -volume-presmooth
  - id: average_output
    type:
      - 'null'
      - boolean
    doc: output the average of the gradient magnitude maps instead of each gradient map separately
    inputBinding:
      position: 12
      prefix: -average-output
  - id: vectors
    type:
      - 'null'
      - string
    doc: 'output gradient vectors: the vectors, as a dscalar file'
    inputBinding:
      position: 13
      prefix: -vectors
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti
    outputBinding:
      glob: $(inputs.cifti_out)
  - id: vectors_file
    type:
      - 'null'
      - File
    doc: the vectors, as a dscalar file
    outputBinding:
      glob: $(inputs.vectors)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
