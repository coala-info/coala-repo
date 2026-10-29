cwlVersion: v1.2
class: CommandLineTool
baseCommand: [fixelfilter]
label: mrtrix3_fixelfilter
doc: |-
  Perform filtering operations on fixel-based data

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: input
    type: [File, Directory]
    doc: 'the input: either a fixel data file, or a fixel directory (see Description)'
    inputBinding:
      position: 1
  - id: filter
    type: string
    doc: 'the filtering operation to perform; options are: connect, smooth (choices: connect smooth)'
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: 'the output: either a fixel data file, or a fixel directory (see Description)'
    inputBinding:
      position: 3
  - id: matrix
    type: Directory
    doc: provide a fixel-fixel connectivity matrix for filtering operations that require it
    inputBinding:
      prefix: -matrix
  - id: threshold_value
    type: ['null', float]
    doc: specify a threshold for the input fixel data file values (default = 0.5)
    inputBinding:
      prefix: -threshold_value
  - id: threshold_connectivity
    type: ['null', float]
    doc: specify a fixel-fixel connectivity threshold for connected-component analysis (default = 0.10000000000000001)
    inputBinding:
      prefix: -threshold_connectivity
  - id: fwhm
    type: ['null', float]
    doc: the full-width half-maximum (FWHM) of the spatial component of the smoothing filter (default
      = 10mm)
    inputBinding:
      prefix: -fwhm
  - id: minweight
    type: ['null', float]
    doc: apply a minimum threshold to smoothing weights (default = 0.01)
    inputBinding:
      prefix: -minweight
  - id: mask
    type: ['null', File]
    doc: only perform smoothing within a specified binary fixel mask
    inputBinding:
      prefix: -mask
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
    type: [File, Directory]
    doc: Filtered fixel data file or fixel directory.
    outputBinding:
      glob: $(inputs.output)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
