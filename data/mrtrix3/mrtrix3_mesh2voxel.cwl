cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mesh2voxel]
label: mrtrix3_mesh2voxel
doc: |-
  Convert a mesh surface to a partial volume estimation image

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: source
    type: File
    doc: the mesh file; note vertices must be defined in realspace coordinates
    inputBinding:
      position: 1
  - id: template
    type: File
    doc: the template image
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: the output image
    inputBinding:
      position: 3
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
  - id: output_out
    type: File
    doc: 'Output: the output image'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
