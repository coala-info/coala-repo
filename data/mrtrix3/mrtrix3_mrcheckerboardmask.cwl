cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrcheckerboardmask]
label: mrtrix3_mrcheckerboardmask
doc: |-
  Create bitwise checkerboard image

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: input
    type: File
    doc: the input image to be used as a template.
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: the output binary image mask.
    inputBinding:
      position: 2
  - id: tiles
    type: ['null', int]
    doc: specify the number of tiles in any direction
    inputBinding:
      prefix: -tiles
  - id: invert
    type: ['null', boolean]
    doc: invert output binary mask.
    inputBinding:
      prefix: -invert
  - id: nan
    type: ['null', boolean]
    doc: use NaN as the output zero value.
    inputBinding:
      prefix: -nan
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
    doc: 'Output: the output binary image mask.'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
