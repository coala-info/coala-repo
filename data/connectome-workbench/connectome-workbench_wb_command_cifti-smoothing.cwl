cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-cifti-smoothing'
label: connectome-workbench_wb_command_cifti-smoothing
doc: "Smooth a cifti file. The input cifti file must have a brain models mapping on the chosen dimension, columns for .dtseries, and either for .dconn. By default, data in different structures is smoothed independently. Surface smoothing uses the GEO_GAUSS_AREA smoothing method.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti
    type: File
    doc: the input cifti
    inputBinding:
      position: 1
  - id: surface_kernel
    type: float
    doc: the sigma for the gaussian surface smoothing kernel, in mm
    inputBinding:
      position: 2
  - id: volume_kernel
    type: float
    doc: the sigma for the gaussian volume smoothing kernel, in mm
    inputBinding:
      position: 3
  - id: direction
    type: string
    doc: which dimension to smooth along, ROW or COLUMN
    inputBinding:
      position: 4
  - id: cifti_out
    type: string
    doc: output - the output cifti
    inputBinding:
      position: 5
  - id: left_surface
    type:
      - 'null'
      - File
    doc: the left surface file
    inputBinding:
      position: 10
      prefix: '-left-surface'
  - id: left_corrected_areas
    type:
      - 'null'
      - File
    doc: 'with left_surface: vertex areas to use instead of computing them from the left surface, as a metric'
    inputBinding:
      position: 11
      prefix: '-left-corrected-areas'
  - id: right_surface
    type:
      - 'null'
      - File
    doc: the right surface file
    inputBinding:
      position: 12
      prefix: '-right-surface'
  - id: right_corrected_areas
    type:
      - 'null'
      - File
    doc: 'with right_surface: vertex areas to use instead of computing them from the right surface, as a metric'
    inputBinding:
      position: 13
      prefix: '-right-corrected-areas'
  - id: cerebellum_surface
    type:
      - 'null'
      - File
    doc: the cerebellum surface file
    inputBinding:
      position: 14
      prefix: '-cerebellum-surface'
  - id: cerebellum_corrected_areas
    type:
      - 'null'
      - File
    doc: 'with cerebellum_surface: vertex areas to use instead of computing them from the cerebellum surface, as a metric'
    inputBinding:
      position: 15
      prefix: '-cerebellum-corrected-areas'
  - id: cifti_roi
    type:
      - 'null'
      - File
    doc: smooth only within regions of interest, given as a cifti file
    inputBinding:
      position: 16
      prefix: '-cifti-roi'
  - id: fix_zeros_volume
    type:
      - 'null'
      - boolean
    doc: treat values of zero in the volume as missing data
    inputBinding:
      position: 17
      prefix: '-fix-zeros-volume'
  - id: fix_zeros_surface
    type:
      - 'null'
      - boolean
    doc: treat values of zero on the surface as missing data
    inputBinding:
      position: 18
      prefix: '-fix-zeros-surface'
  - id: merged_volume
    type:
      - 'null'
      - boolean
    doc: smooth across subcortical structure boundaries
    inputBinding:
      position: 19
      prefix: '-merged-volume'
outputs:
  - id: smoothed_cifti
    type: File
    doc: the output cifti
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
