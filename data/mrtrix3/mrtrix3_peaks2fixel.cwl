cwlVersion: v1.2
class: CommandLineTool
baseCommand: peaks2fixel
label: mrtrix3_peaks2fixel
doc: "Convert peak directions image to a fixel directory\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: directions
    type: File
    doc: "the input directions image; each volume corresponds to the x, y & z component of each direction vector in turn."
    inputBinding:
      position: 1
  - id: fixels
    type: string
    doc: "the output fixel directory."
    inputBinding:
      position: 2
  - id: dataname
    type: ['null', string]
    doc: "the name of the output fixel data file encoding peak amplitudes"
    inputBinding:
      position: 10
      prefix: -dataname
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
  - id: fixels_dir
    type: Directory
    doc: Output directory given by fixels.
    outputBinding:
      glob: $(inputs.fixels)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
