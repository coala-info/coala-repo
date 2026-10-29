cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrcentroid]
label: mrtrix3_mrcentroid
doc: |-
  Determine the centre of mass / centre of gravity of an image

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: input
    type: File
    doc: the input image
    inputBinding:
      position: 1
  - id: mask
    type: ['null', File]
    doc: only include voxels within a mask in the calculation
    inputBinding:
      prefix: -mask
  - id: voxelspace
    type: ['null', boolean]
    doc: report image centre of mass in voxel space rather than scanner space
    inputBinding:
      prefix: -voxelspace
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
stdout: mrcentroid_stdout.txt
