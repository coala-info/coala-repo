cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_5ttedit
doc: "Manually set the partial volume fractions in an ACT five-tissue-type (5TT) image using mask images\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [5ttedit]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: input
    type: File
    doc: "the 5TT image to be modified"
    inputBinding:
      position: 10
  - id: output
    type: string
    doc: "the output modified 5TT image"
    inputBinding:
      position: 11
  - id: cgm
    type: ['null', File]
    doc: "provide a mask of voxels that should be set to cortical grey matter"
    inputBinding:
      prefix: -cgm
  - id: sgm
    type: ['null', File]
    doc: "provide a mask of voxels that should be set to sub-cortical grey matter"
    inputBinding:
      prefix: -sgm
  - id: wm
    type: ['null', File]
    doc: "provide a mask of voxels that should be set to white matter"
    inputBinding:
      prefix: -wm
  - id: csf
    type: ['null', File]
    doc: "provide a mask of voxels that should be set to CSF"
    inputBinding:
      prefix: -csf
  - id: pathological
    type: ['null', File]
    doc: "provide a mask of voxels that should be set to pathological tissue"
    inputBinding:
      prefix: -path
  - id: non_brain
    type: ['null', File]
    doc: "provide a mask of voxels that should be cleared (i.e. are non-brain); note that this will supersede all other provided masks"
    inputBinding:
      prefix: -none
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status; alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non-empty string."
    inputBinding:
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: "display debugging messages."
    inputBinding:
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: "force overwrite of output files (caution: using the same file as input and output might cause unexpected behaviour)."
    inputBinding:
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: "use this number of threads in multi-threaded applications (set to 0 to disable multi-threading)."
    inputBinding:
      prefix: -nthreads
  - id: config
    type:
      - 'null'
      - type: array
        items: string
    doc: "temporarily set the value of an MRtrix config file entry."
    inputBinding:
      prefix: -config
outputs:
  - id: output_file
    type: File
    doc: "the output modified 5TT image"
    outputBinding:
      glob: $(inputs.output)
