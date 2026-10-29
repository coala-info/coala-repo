cwlVersion: v1.2
class: CommandLineTool
baseCommand: [label2mesh]
label: mrtrix3_label2mesh
doc: |-
  Generate meshes from a label image

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: nodes_in
    type: File
    doc: the input node parcellation image
    inputBinding:
      position: 1
  - id: mesh_out
    type: string
    doc: the output mesh file
    inputBinding:
      position: 2
  - id: blocky
    type: ['null', boolean]
    doc: generate 'blocky' meshes with precise delineation of voxel edges, rather than the default Marching
      Cubes approach
    inputBinding:
      prefix: -blocky
  - id: info
    type: ['null', boolean]
    doc: display information messages.
    inputBinding:
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: do not display information messages or progress status; alternatively, this can be achieved by
      setting the MRTRIX_QUIET environment variable to a non-empty string.
    inputBinding:
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: display debugging messages.
    inputBinding:
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: 'force overwrite of output files (caution: using the same file as input and output might cause
      unexpected behaviour).'
    inputBinding:
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: use this number of threads in multi-threaded applications (set to 0 to disable multi-threading).
    inputBinding:
      prefix: -nthreads
outputs:
  - id: mesh_out_out
    type: File
    doc: 'Output: the output mesh file'
    outputBinding:
      glob: $(inputs.mesh_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
