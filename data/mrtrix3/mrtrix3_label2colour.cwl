cwlVersion: v1.2
class: CommandLineTool
baseCommand: [label2colour]
label: mrtrix3_label2colour
doc: |-
  Convert a parcellated image (where values are node indices) into a colour image

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: nodes_in
    type: File
    doc: the input node parcellation image
    inputBinding:
      position: 1
  - id: colour_out
    type: string
    doc: the output colour image
    inputBinding:
      position: 2
  - id: lut
    type: ['null', File]
    doc: Provide the relevant colour lookup table (if not provided, nodes will be coloured randomly)
    inputBinding:
      prefix: -lut
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
  - id: colour_out_out
    type: File
    doc: 'Output: the output colour image'
    outputBinding:
      glob: $(inputs.colour_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
