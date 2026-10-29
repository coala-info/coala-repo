cwlVersion: v1.2
class: CommandLineTool
baseCommand: [meshconvert]
label: mrtrix3_meshconvert
doc: |-
  Convert meshes between different formats, and apply transformations

  Tool homepage: https://www.mrtrix.org
requirements:
  - class: SchemaDefRequirement
    types:
      - name: meshconvert_transform_rec
        type: record
        fields:
          - name: mode
            type: string
            doc: 'mode (choices: first2real real2first voxel2real real2voxel fs2real)'
            inputBinding:
              position: 1
          - name: image
            type: File
            doc: image
            inputBinding:
              position: 2
inputs:
  - id: input
    type: File
    doc: the input mesh file
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: the output mesh file
    inputBinding:
      position: 2
  - id: binary
    type: ['null', boolean]
    doc: write the output mesh file in binary format (if supported)
    inputBinding:
      prefix: -binary
  - id: transform
    type: ['null', meshconvert_transform_rec]
    doc: 'transform vertices from one coordinate space to another, based on a template image; options
      are: first2real, real2first, voxel2real, real2voxel, fs2real'
    inputBinding:
      prefix: -transform
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
    doc: 'Output: the output mesh file'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
