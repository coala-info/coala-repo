cwlVersion: v1.2
class: CommandLineTool
baseCommand: shconv
label: mrtrix3_shconv
doc: "Perform spherical convolution\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: odf_response
    type:
      type: array
      items: File
    doc: "alternating list of input spherical harmonic ODF images and their response function text files: odf response [ odf response ... ]"
    inputBinding:
      position: 1
  - id: sh_out
    type: string
    doc: "the output spherical harmonics coefficients image."
    inputBinding:
      position: 2
  - id: datatype
    type: ['null', string]
    doc: "specify output image data type. Valid choices are: float32, float32le, float32be, float64, float64le, float64be, int64, uint64, int64le, uint64le, int64be, uint64be, int32, uint32, int32le, uint32le, int32be, uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32, cfloat32le, cfloat32be, cfloat64, cfloat64le, cfloat64be, int8, uint8, bit."
    inputBinding:
      position: 10
      prefix: -datatype
  - id: strides
    type: ['null', string]
    doc: "specify the strides of the output data in memory; either as a comma-separated list of (signed) integers, or as a template image from which the strides shall be extracted and used. The actual strides produced will depend on whether the output image format can support it."
    inputBinding:
      position: 10
      prefix: -strides
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      position: 11
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status; alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non-empty string."
    inputBinding:
      position: 11
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: "display debugging messages."
    inputBinding:
      position: 11
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: "force overwrite of output files (caution: using the same file as input and output might cause unexpected behaviour)."
    inputBinding:
      position: 11
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: "use this number of threads in multi-threaded applications (set to 0 to disable multi-threading)."
    inputBinding:
      position: 11
      prefix: -nthreads
  - id: config
    type: ['null', {type: array, items: string}]
    doc: "temporarily set the value of an MRtrix config file entry. Provide the key and the value as two items."
    inputBinding:
      position: 11
      prefix: -config
outputs:
  - id: sh_out_file
    type: File
    doc: Output file given by sh_out.
    outputBinding:
      glob: $(inputs.sh_out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
