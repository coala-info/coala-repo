cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrcalc]
label: mrtrix3_mrcalc
doc: |-
  Apply generic voxel-wise mathematical operations to images

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: operands
    type:
      type: array
      items: [string, File]
    doc: 'Operands and operators in reverse Polish order: images (File), numbers and operator words such
      as -add, -mult, -sqrt, -abs, -if (strings). The operators are listed in the Description of the help;
      the output is given in ''output''.'
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: the output image (the last operand).
    inputBinding:
      position: 2
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
  - id: output_out
    type: File
    doc: Output image.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
