cwlVersion: v1.2
class: CommandLineTool
baseCommand: sh2response
label: mrtrix3_sh2response
doc: "Generate an appropriate response function from the image data for spherical deconvolution\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: sh
    type: File
    doc: "the spherical harmonic decomposition of the diffusion-weighted images"
    inputBinding:
      position: 1
  - id: mask
    type: File
    doc: "the mask containing the voxels from which to estimate the response function"
    inputBinding:
      position: 2
  - id: directions
    type: File
    doc: "a 4D image containing the direction vectors along which to estimate the response function"
    inputBinding:
      position: 3
  - id: response
    type: string
    doc: "the output axially-symmetric spherical harmonic coefficients"
    inputBinding:
      position: 4
  - id: lmax
    type: ['null', string]
    doc: "specify the maximum harmonic degree of the response function to estimate"
    inputBinding:
      position: 10
      prefix: -lmax
  - id: dump
    type: ['null', string]
    doc: "dump the m=0 SH coefficients from all voxels in the mask to the output file, rather than their mean"
    inputBinding:
      position: 10
      prefix: -dump
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
  - id: response_file
    type: File
    doc: Output file given by response.
    outputBinding:
      glob: $(inputs.response)
  - id: dump_file
    type: ['null', File]
    doc: Output file given by -dump.
    outputBinding:
      glob: $(inputs.dump)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
