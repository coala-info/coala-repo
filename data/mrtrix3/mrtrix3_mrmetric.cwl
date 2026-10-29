cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrmetric]
label: mrtrix3_mrmetric
doc: |-
  Computes a dissimilarity metric between two images

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: image1
    type: File
    doc: the first input image.
    inputBinding:
      position: 1
  - id: image2
    type: File
    doc: the second input image.
    inputBinding:
      position: 2
  - id: space
    type: ['null', string]
    doc: 'voxel (default): per voxel image1: scanner space of image 1 image2: scanner space of image 2
      average: scanner space of the average affine transformation of image 1 and 2 (choices: voxel image1
      image2 average)'
    inputBinding:
      prefix: -space
  - id: interp
    type: ['null', string]
    doc: 'set the interpolation method to use when reslicing (choices: nearest, linear, cubic, sinc. Default:
      linear). (choices: nearest linear cubic sinc)'
    inputBinding:
      prefix: -interp
  - id: metric
    type: ['null', string]
    doc: 'define the dissimilarity metric used to calculate the cost. Choices: diff (squared differences),
      cc (non-normalised negative cross correlation aka negative cross covariance). Default: diff). cc
      is only implemented for -space average and -interp linear and cubic. (choices: diff cc)'
    inputBinding:
      prefix: -metric
  - id: mask1
    type: ['null', File]
    doc: mask for image 1
    inputBinding:
      prefix: -mask1
  - id: mask2
    type: ['null', File]
    doc: mask for image 2
    inputBinding:
      prefix: -mask2
  - id: nonormalisation
    type: ['null', boolean]
    doc: do not normalise the dissimilarity metric to the number of voxels.
    inputBinding:
      prefix: -nonormalisation
  - id: overlap
    type: ['null', boolean]
    doc: output number of voxels that were used.
    inputBinding:
      prefix: -overlap
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
  - id: stdout_out
    type: stdout
    doc: Text printed by the command.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stdout: mrmetric_stdout.txt
