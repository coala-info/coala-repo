cwlVersion: v1.2
class: CommandLineTool
baseCommand:
  - wb_command
  - '-cifti-resample-dconn-memory'
label: connectome-workbench_wb_command_cifti-resample-dconn-memory
doc: "Use lots of memory to resample a dconn. Does the same thing as running -cifti-resample twice (COLUMN and ROW), but keeps the intermediate dconn in memory instead of writing it to disk.\n\nTool homepage: https://www.humanconnectome.org/software/connectome-workbench"
inputs:
  - id: cifti_in
    type: File
    doc: the cifti file to resample
    inputBinding:
      position: 1
  - id: cifti_template
    type: File
    doc: a cifti file containing the cifti space to resample to
    inputBinding:
      position: 2
  - id: template_direction
    type: string
    doc: the direction of the template to use as the resampling space, ROW or COLUMN
    inputBinding:
      position: 3
  - id: surface_method
    type: string
    doc: 'surface resampling method: ADAP_BARY_AREA or BARYCENTRIC'
    inputBinding:
      position: 4
  - id: volume_method
    type: string
    doc: 'volume interpolation method: CUBIC, ENCLOSING_VOXEL or TRILINEAR'
    inputBinding:
      position: 5
  - id: cifti_out
    type: string
    doc: output - the output cifti file
    inputBinding:
      position: 6
  - id: surface_largest
    type:
      - 'null'
      - boolean
    doc: use largest weight instead of weighted average or popularity when doing surface resampling
    inputBinding:
      position: 10
      prefix: '-surface-largest'
  - id: volume_predilate
    type:
      - 'null'
      - float
    doc: dilate the volume components before resampling, distance in mm
    inputBinding:
      position: 11
      prefix: '-volume-predilate'
  - id: volume_predilate_nearest
    type:
      - 'null'
      - boolean
    doc: 'with volume_predilate: use nearest value dilation'
    inputBinding:
      position: 12
      prefix: '-nearest'
  - id: volume_predilate_weighted
    type:
      - 'null'
      - boolean
    doc: 'with volume_predilate: use weighted dilation (default)'
    inputBinding:
      position: 13
      prefix: '-weighted'
  - id: volume_predilate_exponent
    type:
      - 'null'
      - float
    doc: 'with volume_predilate_weighted: exponent n in (1 / (distance ^ n)) (default 2)'
    inputBinding:
      position: 14
      prefix: '-exponent'
  - id: surface_postdilate
    type:
      - 'null'
      - float
    doc: dilate the surface components after resampling, distance in mm
    inputBinding:
      position: 15
      prefix: '-surface-postdilate'
  - id: surface_postdilate_nearest
    type:
      - 'null'
      - boolean
    doc: 'with surface_postdilate: use nearest value dilation'
    inputBinding:
      position: 16
      prefix: '-nearest'
  - id: surface_postdilate_linear
    type:
      - 'null'
      - boolean
    doc: 'with surface_postdilate: use linear dilation'
    inputBinding:
      position: 17
      prefix: '-linear'
  - id: surface_postdilate_weighted
    type:
      - 'null'
      - boolean
    doc: 'with surface_postdilate: use weighted dilation'
    inputBinding:
      position: 18
      prefix: '-weighted'
  - id: surface_postdilate_exponent
    type:
      - 'null'
      - float
    doc: 'with surface_postdilate_weighted: exponent n in (area / (distance ^ n)) (default 2)'
    inputBinding:
      position: 19
      prefix: '-exponent'
  - id: affine
    type:
      - 'null'
      - File
    doc: use an affine transformation on the volume components
    inputBinding:
      position: 20
      prefix: '-affine'
  - id: affine_flirt
    type:
      - 'null'
      - type: array
        items: File
    doc: 'with affine: the affine is a flirt affine; two files: source volume, target volume'
    inputBinding:
      position: 21
      prefix: '-flirt'
  - id: warpfield
    type:
      - 'null'
      - File
    doc: use a warpfield on the volume components
    inputBinding:
      position: 22
      prefix: '-warpfield'
  - id: warpfield_fnirt
    type:
      - 'null'
      - File
    doc: 'with warpfield: the warpfield is a fnirt warpfield; the source volume used when generating it'
    inputBinding:
      position: 23
      prefix: '-fnirt'
  - id: left_spheres
    type:
      - 'null'
      - type: array
        items: File
    doc: 'spheres for left surface resampling; two files: current sphere, new sphere in register with it'
    inputBinding:
      position: 24
      prefix: '-left-spheres'
  - id: left_area_surfs
    type:
      - 'null'
      - type: array
        items: File
    doc: 'with left_spheres: left anatomical surfaces for vertex area correction; two files: current mesh, new mesh'
    inputBinding:
      position: 25
      prefix: '-left-area-surfs'
  - id: left_area_metrics
    type:
      - 'null'
      - type: array
        items: File
    doc: 'with left_spheres: left vertex area metrics for area correction; two files: current mesh, new mesh'
    inputBinding:
      position: 26
      prefix: '-left-area-metrics'
  - id: right_spheres
    type:
      - 'null'
      - type: array
        items: File
    doc: 'spheres for right surface resampling; two files: current sphere, new sphere in register with it'
    inputBinding:
      position: 27
      prefix: '-right-spheres'
  - id: right_area_surfs
    type:
      - 'null'
      - type: array
        items: File
    doc: 'with right_spheres: right anatomical surfaces for vertex area correction; two files: current mesh, new mesh'
    inputBinding:
      position: 28
      prefix: '-right-area-surfs'
  - id: right_area_metrics
    type:
      - 'null'
      - type: array
        items: File
    doc: 'with right_spheres: right vertex area metrics for area correction; two files: current mesh, new mesh'
    inputBinding:
      position: 29
      prefix: '-right-area-metrics'
  - id: cerebellum_spheres
    type:
      - 'null'
      - type: array
        items: File
    doc: 'spheres for cerebellum surface resampling; two files: current sphere, new sphere in register with it'
    inputBinding:
      position: 30
      prefix: '-cerebellum-spheres'
  - id: cerebellum_area_surfs
    type:
      - 'null'
      - type: array
        items: File
    doc: 'with cerebellum_spheres: cerebellum anatomical surfaces for vertex area correction; two files: current mesh, new mesh'
    inputBinding:
      position: 31
      prefix: '-cerebellum-area-surfs'
  - id: cerebellum_area_metrics
    type:
      - 'null'
      - type: array
        items: File
    doc: 'with cerebellum_spheres: cerebellum vertex area metrics for area correction; two files: current mesh, new mesh'
    inputBinding:
      position: 32
      prefix: '-cerebellum-area-metrics'
outputs:
  - id: resampled_cifti
    type: File
    doc: the output cifti file
    outputBinding:
      glob: $(inputs.cifti_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/connectome-workbench:1.3.2--h1b11a2a_0
