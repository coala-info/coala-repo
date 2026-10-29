cwlVersion: v1.2
class: CommandLineTool
baseCommand: tckmap
label: mrtrix3_tckmap
doc: "Use track data as a form of contrast for producing a high-resolution image\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: tracks
    type: File
    doc: "the input track file."
    inputBinding:
      position: 1
  - id: output
    type: string
    doc: "the output track-weighted image"
    inputBinding:
      position: 2
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
  - id: datatype
    type: ['null', string]
    doc: "specify output image data type."
    inputBinding:
      position: 10
      prefix: -datatype
  - id: dec
    type: ['null', boolean]
    doc: "perform track mapping in directionally-encoded colour (DEC) space"
    inputBinding:
      position: 10
      prefix: -dec
  - id: dixel
    type: ['null', [File, string]]
    doc: "map streamlines to dixels within each voxel; requires either a number of dixels (references an internal direction set), or a path to a text file containing a set of directions stored as azimuth/elevation pairs"
    inputBinding:
      position: 10
      prefix: -dixel
  - id: tod
    type: ['null', int]
    doc: "generate a Track Orientation Distribution (TOD) in each voxel; need to specify the maximum spherical harmonic degree lmax to use when generating Apodised Point Spread Functions"
    inputBinding:
      position: 10
      prefix: -tod
  - id: contrast
    type: ['null', string]
    doc: "define the desired form of contrast for the output image Options are: tdi, length, invlength, scalar_map, scalar_map_count, fod_amp, curvature, vector_file (default: tdi)"
    inputBinding:
      position: 10
      prefix: -contrast
  - id: image
    type: ['null', File]
    doc: "provide the scalar image map for generating images with 'scalar_map' / 'scalar_map_count' contrast, or the spherical harmonics image for 'fod_amp' contrast"
    inputBinding:
      position: 10
      prefix: -image
  - id: vector_file
    type: ['null', File]
    doc: "provide the vector data file for generating images with 'vector_file' contrast"
    inputBinding:
      position: 10
      prefix: -vector_file
  - id: stat_vox
    type: ['null', string]
    doc: "define the statistic for choosing the final voxel intensities for a given contrast type given the individual values from the tracks passing through each voxel. Options are: sum, min, mean, max (default: sum)"
    inputBinding:
      position: 10
      prefix: -stat_vox
  - id: stat_tck
    type: ['null', string]
    doc: "define the statistic for choosing the contribution to be made by each streamline as a function of the samples taken along their lengths. Only has an effect for 'scalar_map', 'fod_amp' and 'curvature' contrast types. Options are: sum, min, mean, max, median, mean_nonzero, gaussian, ends_min, ends_mean, ends_max, ends_prod (default: mean)"
    inputBinding:
      position: 10
      prefix: -stat_tck
  - id: fwhm_tck
    type: ['null', float]
    doc: "when using gaussian-smoothed per-track statistic, specify the desired full-width half-maximum of the Gaussian smoothing kernel (in mm)"
    inputBinding:
      position: 10
      prefix: -fwhm_tck
  - id: map_zero
    type: ['null', boolean]
    doc: "if a streamline has zero contribution based on the contrast & statistic, typically it is not mapped; use this option to still contribute to the map even if this is the case (these non-contributing voxels can then influence the mean value in each voxel of the map)"
    inputBinding:
      position: 10
      prefix: -map_zero
  - id: backtrack
    type: ['null', boolean]
    doc: "when using -stat_tck ends_*, if the streamline endpoint is outside the FoV, backtrack along the streamline trajectory until an appropriate point is found"
    inputBinding:
      position: 10
      prefix: -backtrack
  - id: upsample
    type: ['null', int]
    doc: "upsample the tracks by some ratio using Hermite interpolation before mappping (If omitted, an appropriate ratio will be determined automatically)"
    inputBinding:
      position: 10
      prefix: -upsample
  - id: precise
    type: ['null', boolean]
    doc: "use a more precise streamline mapping strategy, that accurately quantifies the length through each voxel (these lengths are then taken into account during TWI calculation)"
    inputBinding:
      position: 10
      prefix: -precise
  - id: ends_only
    type: ['null', boolean]
    doc: "only map the streamline endpoints to the image"
    inputBinding:
      position: 10
      prefix: -ends_only
  - id: tck_weights_in
    type: ['null', File]
    doc: "specify a text scalar file containing the streamline weights"
    inputBinding:
      position: 10
      prefix: -tck_weights_in
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
