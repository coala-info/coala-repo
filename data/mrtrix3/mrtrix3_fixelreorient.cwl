cwlVersion: v1.2
class: CommandLineTool
baseCommand: [fixelreorient]
label: mrtrix3_fixelreorient
doc: |-
  Reorient fixel directions

  Tool homepage: https://www.mrtrix.org
inputs:
  - id: fixel_in
    type: Directory
    doc: the input fixel directory
    inputBinding:
      position: 1
  - id: warp
    type: File
    doc: a 4D deformation field used to perform reorientation. Reorientation is performed by applying
      the Jacobian affine transform in each voxel in the warp, then re-normalising the vector representing
      the fixel direction
    inputBinding:
      position: 2
  - id: fixel_out
    type: string
    doc: the output fixel directory. If the the input and output directories are the same, the existing
      directions file will be replaced (providing the -force option is supplied). If a new directory is
      supplied then the fixel directions and all other fixel data will be copied to the new directory.
    inputBinding:
      position: 3
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
  - id: fixel_out_out
    type: Directory
    doc: 'Output: the output fixel directory. If the the input and output directories are the same, the
      existing directions file will be replaced (providing the -force option is supplied). If a new directory
      is supplied then the fixel directions and all other fixel data will be copied to the new directory.'
    outputBinding:
      glob: $(inputs.fixel_out)
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
