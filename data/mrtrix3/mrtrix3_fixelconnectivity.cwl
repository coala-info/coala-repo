cwlVersion: v1.2
class: CommandLineTool
label: mrtrix3_fixelconnectivity
doc: "Generate a fixel-fixel connectivity matrix\n\nTool homepage: https://www.mrtrix.org"
baseCommand: [fixelconnectivity]
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
inputs:
  - id: fixel_directory
    type: Directory
    doc: "the directory containing the fixels between which connectivity will be quantified"
    inputBinding:
      position: 10
  - id: tracks
    type: File
    doc: "the tracks used to determine fixel-fixel connectivity"
    inputBinding:
      position: 11
  - id: matrix
    type: string
    doc: "the output fixel-fixel connectivity matrix directory path"
    inputBinding:
      position: 12
  - id: threshold
    type: ['null', float]
    doc: "a threshold to define the required fraction of shared connections to be included in the neighbourhood (default: 0.01)"
    inputBinding:
      prefix: -threshold
  - id: angle
    type: ['null', float]
    doc: "the max angle threshold for assigning streamline tangents to fixels (Default: 45 degrees)"
    inputBinding:
      prefix: -angle
  - id: mask
    type: ['null', string]
    doc: "provide a fixel data file containing a mask of those fixels to be computed; fixels outside the mask will be empty in the output matrix Give the file name inside the fixel directory."
    inputBinding:
      prefix: -mask
      valueFrom: $(inputs.fixel_directory.path)/$(self)
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
  - id: matrix_dir
    type: Directory
    doc: "the output fixel-fixel connectivity matrix directory path"
    outputBinding:
      glob: $(inputs.matrix)
