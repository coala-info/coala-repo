cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrcolour]
label: mrtrix3_mrcolour
doc: |-
  Apply a colour map to an image

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: input
    type: File
    doc: the input image
    inputBinding:
      position: 1
  - id: map
    type: string
    doc: 'the colourmap to apply; choices are: gray,hot,cool,jet,inferno,viridis,pet,colour,rgb (choices:
      gray hot cool jet inferno viridis pet colour rgb)'
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: the output image
    inputBinding:
      position: 3
  - id: upper
    type: ['null', float]
    doc: manually set the upper intensity of the colour mapping
    inputBinding:
      prefix: -upper
  - id: lower
    type: ['null', float]
    doc: manually set the lower intensity of the colour mapping
    inputBinding:
      prefix: -lower
  - id: colour
    type: ['null', string]
    doc: set the target colour for use of the 'colour' map (three comma-separated floating-point values)
    inputBinding:
      prefix: -colour
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
    doc: 'Output: the output image'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
