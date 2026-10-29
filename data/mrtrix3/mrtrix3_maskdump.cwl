cwlVersion: v1.2
class: CommandLineTool
baseCommand: [maskdump]
label: mrtrix3_maskdump
doc: |-
  Print out the locations of all non-zero voxels in a mask image

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: input
    type: File
    doc: the input image.
    inputBinding:
      position: 1
  - id: output
    type: ['null', string]
    doc: the (optional) output text file.
    inputBinding:
      position: 2
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
    type: ['null', File]
    doc: 'Output: the (optional) output text file.'
    outputBinding:
      glob: $(inputs.output)
  - id: stdout_out
    type: stdout
    doc: Text printed by the command.
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
stdout: maskdump_stdout.txt
