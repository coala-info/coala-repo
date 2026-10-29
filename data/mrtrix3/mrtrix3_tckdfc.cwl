cwlVersion: v1.2
class: CommandLineTool
baseCommand: tckdfc
label: mrtrix3_tckdfc
doc: "Perform the Track-Weighted Dynamic Functional Connectivity (TW-dFC) method\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: tracks
    type: File
    doc: "the input track file."
    inputBinding:
      position: 1
  - id: fmri
    type: File
    doc: "the pre-processed fMRI time series"
    inputBinding:
      position: 2
  - id: output
    type: string
    doc: "the output TW-dFC image"
    inputBinding:
      position: 3
  - id: static
    type: ['null', boolean]
    doc: "generate a \"static\" (3D) output image."
    inputBinding:
      position: 10
      prefix: -static
  - id: dynamic
    type: ['null', dynamic_record]
    doc: "generate a \"dynamic\" (4D) output image; must additionally provide the shape and width (in volumes) of the sliding window."
    inputBinding:
      position: 10
      prefix: -dynamic
  - id: template
    type: ['null', File]
    doc: "an image file to be used as a template for the output (the output image will have the same transform and field of view)."
    inputBinding:
      position: 10
      prefix: -template
  - id: vox
    type: ['null', string]
    doc: "provide either an isotropic voxel size (in mm), or comma-separated list of 3 voxel dimensions."
    inputBinding:
      position: 10
      prefix: -vox
  - id: stat_vox
    type: ['null', string]
    doc: "define the statistic for choosing the final voxel intensities for a given contrast type given the individual values from the tracks passing through each voxel Options are: sum, min, mean, max (default: mean)"
    inputBinding:
      position: 10
      prefix: -stat_vox
  - id: backtrack
    type: ['null', boolean]
    doc: "if no valid timeseries is found at the streamline endpoint, back-track along the streamline trajectory until a valid timeseries is found"
    inputBinding:
      position: 10
      prefix: -backtrack
  - id: upsample
    type: ['null', int]
    doc: "upsample the tracks by some ratio using Hermite interpolation before mapping (if omitted, an appropriate ratio will be determined automatically)"
    inputBinding:
      position: 10
      prefix: -upsample
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
  - class: SchemaDefRequirement
    types:
      - name: dynamic_record
        type: record
        fields:
          - name: shape
            type: string
            inputBinding:
              position: 1
          - name: width
            type: int
            inputBinding:
              position: 2
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
