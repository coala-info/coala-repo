cwlVersion: v1.2
class: CommandLineTool
baseCommand: sh2power
label: mrtrix3_sh2power
doc: "Compute the total power of a spherical harmonics image\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: sh
    type: File
    doc: "the input spherical harmonics coefficients image."
    inputBinding:
      position: 1
  - id: power
    type: string
    doc: "the output power image."
    inputBinding:
      position: 2
  - id: spectrum
    type: ['null', boolean]
    doc: "output the power spectrum, i.e., the power contained within each harmonic degree (l=0, 2, 4, ...) as a 4-D image."
    inputBinding:
      position: 10
      prefix: -spectrum
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
  - id: power_file
    type: File
    doc: Output file given by power.
    outputBinding:
      glob: $(inputs.power)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
