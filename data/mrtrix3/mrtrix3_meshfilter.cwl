cwlVersion: v1.2
class: CommandLineTool
baseCommand: [meshfilter]
label: mrtrix3_meshfilter
doc: |-
  Apply filter operations to meshes

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: input
    type: File
    doc: the input mesh file
    inputBinding:
      position: 1
  - id: filter
    type: string
    doc: 'the filter to apply.Options are: smooth (choices: smooth)'
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: the output mesh file
    inputBinding:
      position: 3
  - id: smooth_spatial
    type: ['null', float]
    doc: 'spatial extent of smoothing (default: 10mm)'
    inputBinding:
      prefix: -smooth_spatial
  - id: smooth_influence
    type: ['null', float]
    doc: 'influence factor for smoothing (default: 10)'
    inputBinding:
      prefix: -smooth_influence
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
    doc: 'Output: the output mesh file'
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
