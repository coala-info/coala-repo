cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_5tt2gmwmi
doc: "Generate a mask image appropriate for seeding streamlines on the grey matter-white matter interface\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [5tt2gmwmi]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: in_5tt_in
    type: File
    doc: "the input 5TT segmented anatomical image"
    inputBinding:
      position: 10
  - id: mask_out
    type: string
    doc: "the output mask image"
    inputBinding:
      position: 11
  - id: mask_in
    type: ['null', File]
    doc: "Filter an input mask image according to those voxels that lie upon the grey matter - white matter boundary. If no input mask is provided, the output will be a whole-brain mask image calculated using the anatomical image only."
    inputBinding:
      prefix: -mask_in
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
  - id: mask_out_file
    type: File
    doc: "the output mask image"
    outputBinding:
      glob: $(inputs.mask_out)
