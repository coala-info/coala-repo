cwlVersion: v1.2
class: CommandLineTool
baseCommand: [labelconvert]
label: mrtrix3_labelconvert
doc: |-
  Convert a connectome node image from one lookup table to another

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: path_in
    type: File
    doc: the input image
    inputBinding:
      position: 1
  - id: lut_in
    type: File
    doc: the connectome lookup table corresponding to the input image
    inputBinding:
      position: 2
  - id: lut_out
    type: File
    doc: the target connectome lookup table for the output image
    inputBinding:
      position: 3
  - id: image_out
    type: string
    doc: the output image
    inputBinding:
      position: 4
  - id: spine
    type: ['null', File]
    doc: provide a manually-defined segmentation of the base of the spine where the streamlines terminate,
      so that this can become a node in the connection matrix.
    inputBinding:
      prefix: -spine
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
  - id: image_out_out
    type: File
    doc: 'Output: the output image'
    outputBinding:
      glob: $(inputs.image_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
