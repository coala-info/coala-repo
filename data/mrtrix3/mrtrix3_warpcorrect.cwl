cwlVersion: v1.2
class: CommandLineTool
baseCommand: warpcorrect
label: mrtrix3_warpcorrect
doc: "Replaces voxels in a deformation field that point to a specific out of bounds location with nan,nan,nan\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: warp_in
    type: File
    doc: "the input warp image."
    inputBinding:
      position: 1
  - id: out
    type: string
    doc: "the output warp image."
    inputBinding:
      position: 2
  - id: marker
    type: ['null', string]
    doc: "single value or a comma separated list of values that define out of bounds voxels in the input warp image. Default: (0,0,0)."
    inputBinding:
      position: 10
      prefix: -marker
  - id: tolerance
    type: ['null', float]
    doc: "numerical precision used for L2 matrix norm comparison. Default: 9.99999975e-06."
    inputBinding:
      position: 10
      prefix: -tolerance
  - id: info
    type: ['null', boolean]
    doc: "display information messages."
    inputBinding:
      position: 11
      prefix: -info
  - id: quiet
    type: ['null', boolean]
    doc: "do not display information messages or progress status; alternatively, this can be achieved by setting the MRTRIX_QUIET environment variable to a non-empty string."
    inputBinding:
      position: 11
      prefix: -quiet
  - id: debug
    type: ['null', boolean]
    doc: "display debugging messages."
    inputBinding:
      position: 11
      prefix: -debug
  - id: force
    type: ['null', boolean]
    doc: "force overwrite of output files (caution: using the same file as input and output might cause unexpected behaviour)."
    inputBinding:
      position: 11
      prefix: -force
  - id: nthreads
    type: ['null', int]
    doc: "use this number of threads in multi-threaded applications (set to 0 to disable multi-threading)."
    inputBinding:
      position: 11
      prefix: -nthreads
  - id: config
    type: ['null', {type: array, items: string}]
    doc: "temporarily set the value of an MRtrix config file entry. Provide the key and the value as two items."
    inputBinding:
      position: 11
      prefix: -config
outputs:
  - id: out_file
    type: File
    doc: Output file given by out.
    outputBinding:
      glob: $(inputs.out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
