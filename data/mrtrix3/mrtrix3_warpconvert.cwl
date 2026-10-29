cwlVersion: v1.2
class: CommandLineTool
baseCommand: warpconvert
label: mrtrix3_warpconvert
doc: "Convert between different representations of a non-linear warp\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: warp_in
    type: File
    doc: "the input warp image."
    inputBinding:
      position: 1
  - id: type
    type: string
    doc: "the conversion type required. Valid choices are: deformation2displacement, displacement2deformation, warpfull2deformation, warpfull2displacement"
    inputBinding:
      position: 2
  - id: out
    type: string
    doc: "the output warp image."
    inputBinding:
      position: 3
  - id: template
    type: ['null', File]
    doc: "define a template image when converting a warpfull file (which is defined on a grid in the midway space between image 1 & 2). For example to generate the deformation field that maps image1 to image2, then supply image2 as the template image"
    inputBinding:
      position: 10
      prefix: -template
  - id: midway_space
    type: ['null', boolean]
    doc: "to be used only with warpfull2deformation and warpfull2displacement conversion types. The output will only contain the non-linear warp to map an input image to the midway space (defined by the warpfull grid). If a linear transform exists in the warpfull file header then it will be composed and included in the output."
    inputBinding:
      position: 10
      prefix: -midway_space
  - id: from
    type: ['null', int]
    doc: "to be used only with warpfull2deformation and warpfull2displacement conversion types. Used to define the direction of the desired output field.Use -from 1 to obtain the image1->image2 field and from 2 for image2->image1. Can be used in combination with the -midway_space option to produce a field that only maps to midway space."
    inputBinding:
      position: 10
      prefix: -from
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
  - id: out_file
    type: File
    doc: Output file given by out.
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
