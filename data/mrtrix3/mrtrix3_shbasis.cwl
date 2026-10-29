cwlVersion: v1.2
class: CommandLineTool
baseCommand: shbasis
label: mrtrix3_shbasis
doc: "Examine the values in spherical harmonic images to estimate (and optionally change) the SH basis used\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: sh
    type:
      type: array
      items: File
    doc: "the input image(s) of SH coefficients."
    inputBinding:
      position: 1
  - id: convert
    type: ['null', string]
    doc: "convert the image data in-place to the desired basis; options are: old,new,force_oldtonew,force_newtoold."
    inputBinding:
      position: 10
      prefix: -convert
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
  - id: converted_images
    type:
      type: array
      items: File
    doc: The input images after the in-place conversion (the same file names as the inputs).
    outputBinding:
      glob: $(inputs.sh.map(function(f){return f.basename;}))
  - id: basis_info
    type: File
    doc: Messages printed by the command to the error stream (the SH basis found for each image).
    outputBinding:
      glob: shbasis.log
stderr: shbasis.log
requirements:
  - class: InitialWorkDirRequirement
    listing: |-
      ${return inputs.sh.map(function(f){return {entry: f, writable: true};});}
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
