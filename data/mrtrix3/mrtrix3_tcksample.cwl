cwlVersion: v1.2
class: CommandLineTool
baseCommand: tcksample
label: mrtrix3_tcksample
doc: "Sample values of an associated image along tracks\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: tracks
    type: File
    doc: "the input track file"
    inputBinding:
      position: 1
  - id: image
    type: File
    doc: "the image to be sampled"
    inputBinding:
      position: 2
  - id: values
    type: string
    doc: "the output sampled values"
    inputBinding:
      position: 3
  - id: stat_tck
    type: ['null', string]
    doc: "compute some statistic from the values along each streamline (options are: mean,median,min,max)"
    inputBinding:
      position: 10
      prefix: -stat_tck
  - id: nointerp
    type: ['null', boolean]
    doc: "do not use trilinear interpolation when sampling image values"
    inputBinding:
      position: 10
      prefix: -nointerp
  - id: precise
    type: ['null', boolean]
    doc: "use the precise mechanism for mapping streamlines to voxels (obviates the need for trilinear interpolation) (only applicable if some per-streamline statistic is requested)"
    inputBinding:
      position: 10
      prefix: -precise
  - id: use_tdi_fraction
    type: ['null', boolean]
    doc: "each streamline is assigned a fraction of the image intensity in each voxel based on the fraction of the track density contributed by that streamline (this is only appropriate for processing a whole-brain tractogram, and images for which the quantiative parameter is additive)"
    inputBinding:
      position: 10
      prefix: -use_tdi_fraction
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
  - id: values_file
    type: File
    doc: Output file given by values.
    outputBinding:
      glob: $(inputs.values)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
