cwlVersion: v1.2
class: CommandLineTool
baseCommand: tcksift
label: mrtrix3_tcksift
doc: "Filter a whole-brain fibre-tracking data set such that the streamline densities match the FOD lobe integrals\n\nTool homepage: https://www.mrtrix.org"
inputs:
  - id: in_tracks
    type: File
    doc: "the input track file"
    inputBinding:
      position: 1
  - id: in_fod
    type: File
    doc: "input image containing the spherical harmonics of the fibre orientation distributions"
    inputBinding:
      position: 2
  - id: out_tracks
    type: string
    doc: "the output filtered tracks file"
    inputBinding:
      position: 3
  - id: nofilter
    type: ['null', boolean]
    doc: "do NOT perform track filtering - just construct the model in order to provide output debugging images"
    inputBinding:
      position: 10
      prefix: -nofilter
  - id: output_at_counts
    type: ['null', string]
    doc: "output filtered track files (and optionally debugging images if -output_debug is specified) at specific numbers of remaining streamlines; provide as comma-separated list of integers"
    inputBinding:
      position: 10
      prefix: -output_at_counts
  - id: proc_mask
    type: ['null', File]
    doc: "provide an image containing the processing mask weights for the model; image spatial dimensions must match the fixel image"
    inputBinding:
      position: 10
      prefix: -proc_mask
  - id: act
    type: ['null', File]
    doc: "use an ACT five-tissue-type segmented anatomical image to derive the processing mask"
    inputBinding:
      position: 10
      prefix: -act
  - id: fd_scale_gm
    type: ['null', boolean]
    doc: "provide this option (in conjunction with -act) to heuristically downsize the fibre density estimates based on the presence of GM in the voxel. This can assist in reducing tissue interface effects when using a single-tissue deconvolution algorithm"
    inputBinding:
      position: 10
      prefix: -fd_scale_gm
  - id: no_dilate_lut
    type: ['null', boolean]
    doc: "do NOT dilate FOD lobe lookup tables; only map streamlines to FOD lobes if the precise tangent lies within the angular spread of that lobe"
    inputBinding:
      position: 10
      prefix: -no_dilate_lut
  - id: make_null_lobes
    type: ['null', boolean]
    doc: "add an additional FOD lobe to each voxel, with zero integral, that covers all directions with zero / negative FOD amplitudes"
    inputBinding:
      position: 10
      prefix: -make_null_lobes
  - id: remove_untracked
    type: ['null', boolean]
    doc: "remove FOD lobes that do not have any streamline density attributed to them; this improves filtering slightly, at the expense of longer computation time (and you can no longer do quantitative comparisons between reconstructions if this is enabled)"
    inputBinding:
      position: 10
      prefix: -remove_untracked
  - id: fd_thresh
    type: ['null', float]
    doc: "fibre density threshold; exclude an FOD lobe from filtering processing if its integral is less than this amount (streamlines will still be mapped to it, but it will not contribute to the cost function or the filtering)"
    inputBinding:
      position: 10
      prefix: -fd_thresh
  - id: csv
    type: ['null', string]
    doc: "output statistics of execution per iteration to a .csv file"
    inputBinding:
      position: 10
      prefix: -csv
  - id: out_mu
    type: ['null', string]
    doc: "output the final value of SIFT proportionality coefficient mu to a text file"
    inputBinding:
      position: 10
      prefix: -out_mu
  - id: output_debug
    type: ['null', boolean]
    doc: "provide various output images for assessing & debugging performance etc."
    inputBinding:
      position: 10
      prefix: -output_debug
  - id: out_selection
    type: ['null', string]
    doc: "output a text file containing the binary selection of streamlines"
    inputBinding:
      position: 10
      prefix: -out_selection
  - id: term_number
    type: ['null', int]
    doc: "number of streamlines - continue filtering until this number of streamlines remain"
    inputBinding:
      position: 10
      prefix: -term_number
  - id: term_ratio
    type: ['null', float]
    doc: "termination ratio - defined as the ratio between reduction in cost function, and reduction in density of streamlines. Smaller values result in more streamlines being filtered out."
    inputBinding:
      position: 10
      prefix: -term_ratio
  - id: term_mu
    type: ['null', float]
    doc: "terminate filtering once the SIFT proportionality coefficient reaches a given value"
    inputBinding:
      position: 10
      prefix: -term_mu
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
  - id: out_tracks_file
    type: File
    doc: Output file given by out_tracks.
    outputBinding:
      glob: $(inputs.out_tracks)
  - id: csv_file
    type: ['null', File]
    doc: Output file given by -csv.
    outputBinding:
      glob: $(inputs.csv)
  - id: out_mu_file
    type: ['null', File]
    doc: Output file given by -out_mu.
    outputBinding:
      glob: $(inputs.out_mu)
  - id: out_selection_file
    type: ['null', File]
    doc: Output file given by -out_selection.
    outputBinding:
      glob: $(inputs.out_selection)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
