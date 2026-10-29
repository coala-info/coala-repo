cwlVersion: v1.2
class: CommandLineTool
baseCommand: tck2fixel
label: mrtrix3_tck2fixel
doc: "Compute a fixel TDI map from a tractogram\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: tracks
    type: File
    doc: "the input tracks."
    inputBinding:
      position: 1
  - id: fixel_folder_in
    type: Directory
    doc: "the input fixel folder. Used to define the fixels and their directions"
    inputBinding:
      position: 2
  - id: fixel_folder_out
    type: string
    doc: "the fixel folder to which the output will be written. This can be the same as the input folder if desired"
    inputBinding:
      position: 3
  - id: fixel_data_out
    type: string
    doc: "the name of the fixel data image."
    inputBinding:
      position: 4
  - id: angle
    type: ['null', float]
    doc: "the max angle threshold for assigning streamline tangents to fixels (Default: 45 degrees)"
    inputBinding:
      position: 10
      prefix: -angle
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
  - id: fixel_folder_out_dir
    type: Directory
    doc: Output directory given by fixel_folder_out.
    outputBinding:
      glob: $(inputs.fixel_folder_out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
