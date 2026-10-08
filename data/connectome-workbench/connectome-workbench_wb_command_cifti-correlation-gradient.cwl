cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - -cifti-correlation-gradient
label: connectome-workbench_wb_command_cifti-correlation-gradient
doc: "For each structure, compute the correlation of the rows in the structure, and take the gradients of the resulting rows, then average them. Memory limit does not need to be an integer, you may also specify 0 to use as little memory as possible (this may be very slow).\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti
    type: File
    doc: the input cifti
    inputBinding:
      position: 1
  - id: cifti_out
    type: string
    doc: the output cifti
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
  - id: left_corrected_areas
    type:
      - 'null'
      - File
    doc: 'vertex areas to use instead of computing them from the left surface: the corrected vertex areas, as a metric (use with -left-surface)'
    inputBinding:
      position: 4
      prefix: -left-corrected-areas
  - id: right_surface
    type:
      - 'null'
      - File
    doc: 'specify the right surface to use: the right surface file'
    inputBinding:
      position: 5
      prefix: -right-surface
  - id: right_corrected_areas
    type:
      - 'null'
      - File
    doc: 'vertex areas to use instead of computing them from the right surface: the corrected vertex areas, as a metric (use with -right-surface)'
    inputBinding:
      position: 6
      prefix: -right-corrected-areas
  - id: cerebellum_surface
    type:
      - 'null'
      - File
    doc: 'specify the cerebellum surface to use: the cerebellum surface file'
    inputBinding:
      position: 7
      prefix: -cerebellum-surface
  - id: cerebellum_corrected_areas
    type:
      - 'null'
      - File
    doc: 'vertex areas to use instead of computing them from the cerebellum surface: the corrected vertex areas, as a metric (use with -cerebellum-surface)'
    inputBinding:
      position: 8
      prefix: -cerebellum-corrected-areas
  - id: surface_presmooth
    type:
      - 'null'
      - float
    doc: 'smooth on the surface before computing the gradient: the sigma for the gaussian surface smoothing kernel, in mm'
    inputBinding:
      position: 9
      prefix: -surface-presmooth
  - id: volume_presmooth
    type:
      - 'null'
      - float
    doc: 'smooth the volume before computing the gradient: the sigma for the gaussian volume smoothing kernel, in mm'
    inputBinding:
      position: 10
      prefix: -volume-presmooth
  - id: undo_fisher_z
    type:
      - 'null'
      - boolean
    doc: apply the inverse fisher small z transform to the input
    inputBinding:
      position: 11
      prefix: -undo-fisher-z
  - id: fisher_z
    type:
      - 'null'
      - boolean
    doc: apply the fisher small z transform to the correlations before taking the gradient
    inputBinding:
      position: 12
      prefix: -fisher-z
  - id: surface_exclude
    type:
      - 'null'
      - float
    doc: 'exclude vertices near each seed vertex from computation: geodesic distance from seed vertex for the exclusion zone, in mm'
    inputBinding:
      position: 13
      prefix: -surface-exclude
  - id: volume_exclude
    type:
      - 'null'
      - float
    doc: 'exclude voxels near each seed voxel from computation: distance from seed voxel for the exclusion zone, in mm'
    inputBinding:
      position: 14
      prefix: -volume-exclude
  - id: covariance
    type:
      - 'null'
      - boolean
    doc: compute covariance instead of correlation
    inputBinding:
      position: 15
      prefix: -covariance
  - id: mem_limit
    type:
      - 'null'
      - float
    doc: 'restrict memory usage: memory limit in gigabytes'
    inputBinding:
      position: 16
      prefix: -mem-limit
outputs:
  - id: cifti_out_file
    type: File
    doc: the output cifti
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
