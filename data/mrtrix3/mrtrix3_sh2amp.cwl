cwlVersion: v1.2
class: CommandLineTool
baseCommand: sh2amp
label: mrtrix3_sh2amp
doc: "Evaluate the amplitude of an image of spherical harmonic functions along specified directions\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: input
    type: File
    doc: "the input image consisting of spherical harmonic (SH) coefficients."
    inputBinding:
      position: 1
  - id: directions
    type: File
    doc: "the list of directions along which the SH functions will be sampled, generated using the dirgen command"
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: "the output image consisting of the amplitude of the SH functions along the specified directions."
    inputBinding:
      position: 3
  - id: nonnegative
    type: ['null', boolean]
    doc: "cap all negative amplitudes to zero"
    inputBinding:
      position: 10
      prefix: -nonnegative
  - id: grad
    type: ['null', File]
    doc: "Provide the diffusion-weighted gradient scheme used in the acquisition in a text file. This should be supplied as a 4xN text file with each line is in the format [ X Y Z b ], where [ X Y Z ] describe the direction of the applied gradient, and b gives the b-value in units of s/mm^2. If a diffusion gradient scheme is present in the input image header, the data provided with this option will be instead used."
    inputBinding:
      position: 10
      prefix: -grad
  - id: fslgrad
    type: ['null', fslgrad_record]
    doc: "Provide the diffusion-weighted gradient scheme used in the acquisition in FSL bvecs/bvals format files. If a diffusion gradient scheme is present in the input image header, the data provided with this option will be instead used."
    inputBinding:
      position: 10
      prefix: -fslgrad
  - id: strides
    type: ['null', string]
    doc: "specify the strides of the output data in memory; either as a comma-separated list of (signed) integers, or as a template image from which the strides shall be extracted and used. The actual strides produced will depend on whether the output image format can support it."
    inputBinding:
      position: 10
      prefix: -strides
  - id: datatype
    type: ['null', string]
    doc: "specify output image data type. Valid choices are: float32, float32le, float32be, float64, float64le, float64be, int64, uint64, int64le, uint64le, int64be, uint64be, int32, uint32, int32le, uint32le, int32be, uint32be, int16, uint16, int16le, uint16le, int16be, uint16be, cfloat32, cfloat32le, cfloat32be, cfloat64, cfloat64le, cfloat64be, int8, uint8, bit."
    inputBinding:
      position: 10
      prefix: -datatype
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
  - id: output_file
    type: File
    doc: Output file given by output.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: SchemaDefRequirement
    types:
      - name: fslgrad_record
        type: record
        fields:
          - name: bvecs
            type: File
            inputBinding:
              position: 1
          - name: bvals
            type: File
            inputBinding:
              position: 2
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
