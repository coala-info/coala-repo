cwlVersion: v1.2
class: CommandLineTool
baseCommand: sh2peaks
label: mrtrix3_sh2peaks
doc: "Extract the peaks of a spherical harmonic function in each voxel\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: sh
    type: File
    doc: "the input image of SH coefficients."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "the output image. Each volume corresponds to the x, y & z component of each peak direction vector in turn."
    inputBinding:
      position: 2
  - id: num
    type: ['null', int]
    doc: "the number of peaks to extract (default: 3)."
    inputBinding:
      position: 10
      prefix: -num
  - id: direction
    type:
      - 'null'
      - type: array
        items: direction_record
        inputBinding:
          prefix: -direction
    doc: "the direction of a peak to estimate. The algorithm will attempt to find the same number of peaks as have been specified using this option."
    inputBinding:
      position: 10
  - id: peaks
    type: ['null', File]
    doc: "the program will try to find the peaks that most closely match those in the image provided."
    inputBinding:
      position: 10
      prefix: -peaks
  - id: threshold
    type: ['null', float]
    doc: "only peak amplitudes greater than the threshold will be considered."
    inputBinding:
      position: 10
      prefix: -threshold
  - id: seeds
    type: ['null', File]
    doc: "specify a set of directions from which to start the multiple restarts of the optimisation (by default, the built-in 60 direction set is used)"
    inputBinding:
      position: 10
      prefix: -seeds
  - id: mask
    type: ['null', File]
    doc: "only perform computation within the specified binary brain mask image."
    inputBinding:
      position: 10
      prefix: -mask
  - id: fast
    type: ['null', boolean]
    doc: "use lookup table to compute associated Legendre polynomials (faster, but approximate)."
    inputBinding:
      position: 10
      prefix: -fast
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
      - name: direction_record
        type: record
        fields:
          - name: phi
            type: float
            inputBinding:
              position: 1
          - name: theta
            type: float
            inputBinding:
              position: 2
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
