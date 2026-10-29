cwlVersion: v1.2
class: CommandLineTool
baseCommand: [mrstats]
label: mrtrix3_mrstats
doc: |-
  Compute images statistics

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: image
    type: File
    doc: the input image from which statistics will be computed.
    inputBinding:
      position: 1
  - id: output
    type:
      - 'null'
      - type: array
        items: string
        inputBinding:
          prefix: -output
    doc: 'output only the field specified. Multiple such options can be supplied if required. Choices
      are: mean, median, std, std_rv, min, max, count. Useful for use in scripts. Both std options refer
      to the unbiased (sample) standard deviation. For complex data, min, max and std are calculated separately
      for real and imaginary parts, std_rv is based on the real valued variance (equals sqrt of sum of
      variances of imaginary and real parts). (choices: mean median std std_rv min max count)'
  - id: mask
    type: ['null', File]
    doc: only perform computation within the specified binary mask image.
    inputBinding:
      prefix: -mask
  - id: ignorezero
    type: ['null', boolean]
    doc: ignore zero values during statistics calculation
    inputBinding:
      prefix: -ignorezero
  - id: allvolumes
    type: ['null', boolean]
    doc: generate statistics across all image volumes, rather than one set of statistics per image volume
    inputBinding:
      prefix: -allvolumes
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
stdout: mrstats_stdout.txt
