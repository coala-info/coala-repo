cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrdegibbs]
label: mrtrix3_mrdegibbs
doc: |-
  Remove Gibbs Ringing Artifacts

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: in_image
    type: File
    doc: the input image.
    inputBinding:
      position: 1
  - id: out_image
    type: string
    doc: the output image.
    inputBinding:
      position: 2
  - id: axes
    type: ['null', string]
    doc: 'select the slice axes (default: 0,1 - i.e. x-y).'
    inputBinding:
      prefix: -axes
  - id: nshifts
    type: ['null', int]
    doc: 'discretization of subpixel spacing (default: 20).'
    inputBinding:
      prefix: -nshifts
  - id: minW
    type: ['null', int]
    doc: 'left border of window used for TV computation (default: 1).'
    inputBinding:
      prefix: -minW
  - id: maxW
    type: ['null', int]
    doc: 'right border of window used for TV computation (default: 3).'
    inputBinding:
      prefix: -maxW
  - id: datatype
    type: ['null', string]
    doc: 'specify output image data type. Valid choices are: float32, float32le, float32be, float64, float64le,
      float64be, int64, uint64, int64le, uint64le, int64be, uint64be, int32, uint32, int32le, uint32le,
      int32be, uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32, cfloat32le, cfloat32be,
      cfloat64, cfloat64le, cfloat64be, int8, uint8, bit. (choices: float32 float32le float32be float64
      float64le float64be int64 uint64 int64le uint64le int64be uint64be int32 uint32 int32le uint32le
      int32be uint32be int16 uint16 int16le uint16le int16be uint16be cfloat32 cfloat32le cfloat32be cfloat64
      cfloat64le cfloat64be int8 uint8 bit)'
    inputBinding:
      prefix: -datatype
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
  - id: out_image_out
    type: File
    doc: 'Output: the output image.'
    outputBinding:
      glob: $(inputs.out_image)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
