cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_5tt2vis
doc: "Generate an image for visualisation purposes from an ACT 5TT segmented anatomical image\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [5tt2vis]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: input
    type: File
    doc: "the input 4D tissue-segmented image"
    inputBinding:
      position: 10
  - id: output
    type: string
    doc: "the output 3D image for visualisation"
    inputBinding:
      position: 11
  - id: bg
    type: ['null', float]
    doc: "image intensity of background (default: 0)"
    inputBinding:
      prefix: -bg
  - id: cgm
    type: ['null', float]
    doc: "image intensity of cortical grey matter (default: 0.5)"
    inputBinding:
      prefix: -cgm
  - id: sgm
    type: ['null', float]
    doc: "image intensity of sub-cortical grey matter (default: 0.75)"
    inputBinding:
      prefix: -sgm
  - id: wm
    type: ['null', float]
    doc: "image intensity of white matter (default: 1)"
    inputBinding:
      prefix: -wm
  - id: csf
    type: ['null', float]
    doc: "image intensity of CSF (default: 0.15)"
    inputBinding:
      prefix: -csf
  - id: pathological
    type: ['null', float]
    doc: "image intensity of pathological tissue (default: 2)"
    inputBinding:
      prefix: -path
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
    doc: "the output 3D image for visualisation"
    outputBinding:
      glob: $(inputs.output)
