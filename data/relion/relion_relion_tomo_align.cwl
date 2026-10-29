cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_tomo_align
label: relion_relion_tomo_align
doc: "Align tilt-series frames to a reference using particles (frame alignment, optional motion and deformation\
  \ estimation).\n\nTool homepage: https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: optimisation_set
    type:
      - 'null'
      - File
    doc: Optimisation set
    inputBinding:
      position: 101
      prefix: --i
  - id: particle_set
    type:
      - 'null'
      - File
    doc: Particle set
    inputBinding:
      position: 101
      prefix: --p
  - id: tomogram_set
    type:
      - 'null'
      - File
    doc: Tomogram set
    inputBinding:
      position: 101
      prefix: --t
  - id: trajectories_set
    type:
      - 'null'
      - File
    doc: Particle trajectories set
    inputBinding:
      position: 101
      prefix: --mot
  - id: reference_half1
    type:
      - 'null'
      - File
    doc: Reference map, half 1
    inputBinding:
      position: 101
      prefix: --ref1
  - id: reference_half2
    type:
      - 'null'
      - File
    doc: Reference map, half 2
    inputBinding:
      position: 101
      prefix: --ref2
  - id: reference_mask
    type:
      - 'null'
      - File
    doc: Reference mask
    inputBinding:
      position: 101
      prefix: --mask
  - id: reference_fsc
    type:
      - 'null'
      - File
    doc: Star file containing the FSC of the reference
    inputBinding:
      position: 101
      prefix: --fsc
  - id: freq_cutoff
    type:
      - 'null'
      - float
    doc: 'Explicit cutoff frequency (in Å; negative to turn off) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --freq_cutoff
  - id: fsc_thresh_width
    type:
      - 'null'
      - float
    doc: 'Width of the frq. weight flank (RELION default: 5)'
    inputBinding:
      position: 101
      prefix: --fsc_thresh_width
  - id: use_SNR_weight
    type:
      - 'null'
      - boolean
    doc: Weight each shell proportionally to its reference-map confidence
    inputBinding:
      position: 101
      prefix: --use_SNR_weight
  - id: box_size
    type: int
    doc: Box size
    inputBinding:
      position: 101
      prefix: --b
  - id: output
    type: string
    doc: Output directory
    inputBinding:
      position: 101
      prefix: --o
  - id: only_do_unfinished
    type:
      - 'null'
      - boolean
    doc: Only process tomograms for which no temporary output data can be found
    inputBinding:
      position: 101
      prefix: --only_do_unfinished
  - id: per_frame_noise
    type:
      - 'null'
      - boolean
    doc: Assume a different noise distribution for each frame
    inputBinding:
      position: 101
      prefix: --per_frame_noise
  - id: diag
    type:
      - 'null'
      - boolean
    doc: Write out diagnostic information
    inputBinding:
      position: 101
      prefix: --diag
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of OMP threads (RELION default: 6)'
    inputBinding:
      position: 101
      prefix: --j
  - id: shift_only
    type:
      - 'null'
      - boolean
    doc: Only apply an optimal rigid shift to each frame (no iterative optimisation; useful for very badly
      aligned frames)
    inputBinding:
      position: 101
      prefix: --shift_only
  - id: shift_only_by_particles
    type:
      - 'null'
      - boolean
    doc: Estimate rigid shift by aligning only the particles instead of by predicting entire micrographs
    inputBinding:
      position: 101
      prefix: --shift_only_by_particles
  - id: r
    type:
      - 'null'
      - float
    doc: 'Max. particle shift allowed [Pixels] (RELION default: 20)'
    inputBinding:
      position: 101
      prefix: --r
  - id: const_p
    type:
      - 'null'
      - boolean
    doc: Keep the particle positions constant
    inputBinding:
      position: 101
      prefix: --const_p
  - id: const_a
    type:
      - 'null'
      - boolean
    doc: Keep the frame angles constant
    inputBinding:
      position: 101
      prefix: --const_a
  - id: const_s
    type:
      - 'null'
      - boolean
    doc: Keep the frame shifts constant
    inputBinding:
      position: 101
      prefix: --const_s
  - id: range_reg
    type:
      - 'null'
      - float
    doc: 'Value of the range regulariser (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --range_reg
  - id: aniso
    type:
      - 'null'
      - boolean
    doc: Assume an anisotropic projection model
    inputBinding:
      position: 101
      prefix: --aniso
  - id: per_tilt_aniso
    type:
      - 'null'
      - boolean
    doc: Fit independent view anisotropy for each tilt image
    inputBinding:
      position: 101
      prefix: --per_tilt_aniso
  - id: it
    type:
      - 'null'
      - int
    doc: 'Max. number of iterations (RELION default: 10000)'
    inputBinding:
      position: 101
      prefix: --it
  - id: motion
    type:
      - 'null'
      - boolean
    doc: Estimate particle motion (expensive)
    inputBinding:
      position: 101
      prefix: --motion
  - id: s_vel
    type:
      - 'null'
      - float
    doc: 'Velocity sigma [Å/dose] (RELION default: 0.5)'
    inputBinding:
      position: 101
      prefix: --s_vel
  - id: s_div
    type:
      - 'null'
      - float
    doc: 'Divergence sigma [Å] (RELION default: 5000.0)'
    inputBinding:
      position: 101
      prefix: --s_div
  - id: abs_params
    type:
      - 'null'
      - boolean
    doc: Do not scale the sigmas by the dose
    inputBinding:
      position: 101
      prefix: --abs_params
  - id: sq_exp_ker
    type:
      - 'null'
      - boolean
    doc: Use a square-exponential kernel instead of an exponential one
    inputBinding:
      position: 101
      prefix: --sq_exp_ker
  - id: max_ed
    type:
      - 'null'
      - float
    doc: 'Maximum number of eigendeformations (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --max_ed
  - id: deformation
    type:
      - 'null'
      - boolean
    doc: Estimate 2D deformations
    inputBinding:
      position: 101
      prefix: --deformation
  - id: def_w
    type:
      - 'null'
      - int
    doc: 'Number of horizontal sampling points for the deformation grid (RELION default: 3)'
    inputBinding:
      position: 101
      prefix: --def_w
  - id: def_h
    type:
      - 'null'
      - int
    doc: 'Number of vertical sampling points for the deformation grid (RELION default: 3)'
    inputBinding:
      position: 101
      prefix: --def_h
  - id: def_model
    type:
      - 'null'
      - string
    doc: 'Type of model to use (linear, spline or Fourier) (RELION default: spline)'
    inputBinding:
      position: 101
      prefix: --def_model
  - id: def_reg
    type:
      - 'null'
      - float
    doc: 'Value of the deformation regulariser (RELION default: 0.0)'
    inputBinding:
      position: 101
      prefix: --def_reg
  - id: per_frame_deformation
    type:
      - 'null'
      - boolean
    doc: Model separate 2D deformations for all tilts
    inputBinding:
      position: 101
      prefix: --per_frame_deformation
  - id: pad
    type:
      - 'null'
      - float
    doc: 'Apply Fourier padding to the cross-correlation images (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --pad
  - id: no_whiten
    type:
      - 'null'
      - boolean
    doc: Do not not whiten the noise spectra
    inputBinding:
      position: 101
      prefix: --no_whiten
  - id: whiten_abs
    type:
      - 'null'
      - boolean
    doc: Divide by the square root of the power spectrum
    inputBinding:
      position: 101
      prefix: --whiten_abs
  - id: hp
    type:
      - 'null'
      - float
    doc: 'High-pass filter the cross-correlation images by this sigma (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --hp
  - id: srp
    type:
      - 'null'
      - int
    doc: 'Noise variance is divided by k^this during whitening (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --srp
  - id: min_frame
    type:
      - 'null'
      - int
    doc: 'First frame to consider (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --min_frame
  - id: max_frame
    type:
      - 'null'
      - int
    doc: 'Last frame to consider (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --max_frame
  - id: cutoff_fract
    type:
      - 'null'
      - float
    doc: 'Ignore shells for which the relative dose or frequency weight falls below this fraction of the
      average (RELION default: 0.02)'
    inputBinding:
      position: 101
      prefix: --cutoff_fract
  - id: theme
    type:
      - 'null'
      - string
    doc: 'Select display theme (RELION default: molten)'
    inputBinding:
      position: 101
      prefix: --theme
  - id: list_themes
    type:
      - 'null'
      - boolean
    doc: List available themes and quit
    inputBinding:
      position: 101
      prefix: --list_themes
  - id: staged_files
    type:
      - 'null'
      - type: array
        items: File
    doc: Extra files that the input STAR file names (images, micrographs, maps, coordinate files). They
      are staged in the working directory so that the relative names in the STAR file resolve.
outputs:
  - id: output_dir
    type: Directory
    doc: Output directory with the optimisation set, tomograms and trajectories
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_tomo_align.out
