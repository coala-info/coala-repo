cwlVersion: v1.2
class: CommandLineTool
baseCommand: voxel2fixel
label: mrtrix3_voxel2fixel
doc: "Map the scalar value in each voxel to all fixels within that voxel\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: image_in
    type: File
    doc: "the input image."
    inputBinding:
      position: 1
  - id: fixel_directory_in
    type: Directory
    doc: "the input fixel directory. Used to define the fixels and their directions"
    inputBinding:
      position: 2
  - id: fixel_directory_out
    type: string
    doc: "the fixel directory where the output will be written. This can be the same as the input directory if desired"
    inputBinding:
      position: 3
  - id: fixel_data_out
    type: string
    doc: "the name of the fixel data image."
    inputBinding:
      position: 4
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
  - id: fixel_directory_out_dir
    type: Directory
    doc: Output directory given by fixel_directory_out.
    outputBinding:
      glob: $(inputs.fixel_directory_out)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
