cwlVersion: v1.2
class: CommandLineTool
baseCommand: tcksift2
label: mrtrix3_tcksift2
doc: "Optimise per-streamline cross-section multipliers to match a whole-brain tractogram to fixel-wise fibre densities\n\nTool homepage: https://www.mrtrix.org"
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
  - id: out_weights
    type: string
    doc: "output text file containing the weighting factor for each streamline"
    inputBinding:
      position: 3
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
  - id: out_coeffs
    type: ['null', string]
    doc: "output text file containing the weighting coefficient for each streamline"
    inputBinding:
      position: 10
      prefix: -out_coeffs
  - id: reg_tikhonov
    type: ['null', float]
    doc: "provide coefficient for regularising streamline weighting coefficients (Tikhonov regularisation) (default: 0)"
    inputBinding:
      position: 10
      prefix: -reg_tikhonov
  - id: reg_tv
    type: ['null', float]
    doc: "provide coefficient for regularising variance of streamline weighting coefficient to fixels along its length (Total Variation regularisation) (default: 0.1)"
    inputBinding:
      position: 10
      prefix: -reg_tv
  - id: min_td_frac
    type: ['null', float]
    doc: "minimum fraction of the FOD integral reconstructed by streamlines; if the reconstructed streamline density is below this fraction, the fixel is excluded from optimisation (default: 0.1)"
    inputBinding:
      position: 10
      prefix: -min_td_frac
  - id: min_iters
    type: ['null', int]
    doc: "minimum number of iterations to run before testing for convergence; this can prevent premature termination at early iterations if the cost function increases slightly (default: 10)"
    inputBinding:
      position: 10
      prefix: -min_iters
  - id: max_iters
    type: ['null', int]
    doc: "maximum number of iterations to run before terminating program"
    inputBinding:
      position: 10
      prefix: -max_iters
  - id: min_factor
    type: ['null', float]
    doc: "minimum weighting factor for an individual streamline; if the factor falls below this number the streamline will be rejected entirely (factor set to zero) (default: 0)"
    inputBinding:
      position: 10
      prefix: -min_factor
  - id: min_coeff
    type: ['null', float]
    doc: "minimum weighting coefficient for an individual streamline; similar to the '-min_factor' option, but using the exponential coefficient basis of the SIFT2 model; these parameters are related as: factor = e^(coeff). Note that the -min_factor and -min_coeff options are mutually exclusive - you can only provide one. (default: -inf)"
    inputBinding:
      position: 10
      prefix: -min_coeff
  - id: max_factor
    type: ['null', float]
    doc: "maximum weighting factor that can be assigned to any one streamline (default: inf)"
    inputBinding:
      position: 10
      prefix: -max_factor
  - id: max_coeff
    type: ['null', float]
    doc: "maximum weighting coefficient for an individual streamline; similar to the '-max_factor' option, but using the exponential coefficient basis of the SIFT2 model; these parameters are related as: factor = e^(coeff). Note that the -max_factor and -max_coeff options are mutually exclusive - you can only provide one. (default: inf)"
    inputBinding:
      position: 10
      prefix: -max_coeff
  - id: max_coeff_step
    type: ['null', float]
    doc: "maximum change to a streamline's weighting coefficient in a single iteration (default: 1)"
    inputBinding:
      position: 10
      prefix: -max_coeff_step
  - id: min_cf_decrease
    type: ['null', float]
    doc: "minimum decrease in the cost function (as a fraction of the initial value) that must occur each iteration for the algorithm to continue (default: 2.5e-05)"
    inputBinding:
      position: 10
      prefix: -min_cf_decrease
  - id: linear
    type: ['null', boolean]
    doc: "perform a linear estimation of streamline weights, rather than the standard non-linear optimisation (typically does not provide as accurate a model fit; but only requires a single pass)"
    inputBinding:
      position: 10
      prefix: -linear
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
  - id: out_weights_file
    type: File
    doc: Output file given by out_weights.
    outputBinding:
      glob: $(inputs.out_weights)
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
  - id: out_coeffs_file
    type: ['null', File]
    doc: Output file given by -out_coeffs.
    outputBinding:
      glob: $(inputs.out_coeffs)
requirements:
  - class: InlineJavascriptRequirement
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/mrtrix3:3.0.8--h8aef656_0
