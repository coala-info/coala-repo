cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mredit]
label: mrtrix3_mredit
doc: |-
  Directly edit the intensities within an image from the command-line

  Tool homepage: https://www.mrtrix.org
requirements:
  - class: SchemaDefRequirement
    types:
      - name: mredit_plane_rec
        type: record
        fields:
          - name: axis
            type: int
            doc: axis
            inputBinding:
              position: 1
          - name: coord
            type: string
            doc: coord
            inputBinding:
              position: 2
          - name: value
            type: float
            doc: value
            inputBinding:
              position: 3
      - name: mredit_sphere_rec
        type: record
        fields:
          - name: position
            type: string
            doc: position
            inputBinding:
              position: 1
          - name: radius
            type: float
            doc: radius
            inputBinding:
              position: 2
          - name: value
            type: float
            doc: value
            inputBinding:
              position: 3
      - name: mredit_voxel_rec
        type: record
        fields:
          - name: position
            type: string
            doc: position
            inputBinding:
              position: 1
          - name: value
            type: float
            doc: value
            inputBinding:
              position: 2
inputs:
  - id: input
    type: File
    doc: the input image
    inputBinding:
      position: 1
  - id: output
    type: ['null', string]
    doc: the (optional) output image
    inputBinding:
      position: 2
  - id: plane
    type:
      - 'null'
      - type: array
        items: mredit_plane_rec
        inputBinding:
          prefix: -plane
    doc: fill one or more planes on a particular image axis
  - id: sphere
    type:
      - 'null'
      - type: array
        items: mredit_sphere_rec
        inputBinding:
          prefix: -sphere
    doc: draw a sphere with radius in mm
  - id: voxel
    type:
      - 'null'
      - type: array
        items: mredit_voxel_rec
        inputBinding:
          prefix: -voxel
    doc: change the image value within a single voxel
  - id: scanner
    type: ['null', boolean]
    doc: indicate that coordinates are specified in scanner space, rather than as voxel coordinates
    inputBinding:
      prefix: -scanner
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
    type: ['null', File]
    doc: 'Output: the (optional) output image'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
