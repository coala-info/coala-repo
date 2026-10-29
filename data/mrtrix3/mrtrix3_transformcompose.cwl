cwlVersion: v1.2
class: CommandLineTool
baseCommand: transformcompose
label: mrtrix3_transformcompose
doc: "Compose any number of linear transformations and/or warps into a single transformation\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: input
    type:
      type: array
      items: File
    doc: "the input transforms (either linear or non-linear warps)."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "the output file (may be a linear transformation text file, or a deformation warp field image, depending on usage)"
    inputBinding:
      position: 2
  - id: template
    type: ['null', File]
    doc: "define the output grid defined by a template image"
    inputBinding:
      position: 10
      prefix: -template
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
  - id: output_file
    type: File
    doc: Output file given by output.
    outputBinding:
      glob: $(inputs.output)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
