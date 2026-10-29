cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_motion_refine
label: relion_relion_motion_refine
doc: "Bayesian polishing: fit per-particle motion trajectories and combine movie frames.\n\nTool homepage:\
  \ https://github.com/3dem/relion"
requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.staged_files)
inputs:
  - id: input
    type: File
    doc: Input STAR file
    inputBinding:
      position: 101
      prefix: --i
  - id: output
    type: string
    doc: Output directory, e.g. MotionFit/job041/
    inputBinding:
      position: 101
      prefix: --o
  - id: fsc_star
    type: File
    doc: Input STAR file with the FSC of the reference (usually from PostProcess)
    inputBinding:
      position: 101
      prefix: --f
  - id: m1
    type:
      - 'null'
      - File
    doc: Reference map, half 1
    inputBinding:
      position: 101
      prefix: --m1
  - id: m2
    type:
      - 'null'
      - File
    doc: Reference map, half 2
    inputBinding:
      position: 101
      prefix: --m2
  - id: a1
    type:
      - 'null'
      - File
    doc: Amplitude reference map, half 1
    inputBinding:
      position: 101
      prefix: --a1
  - id: a2
    type:
      - 'null'
      - File
    doc: Amplitude reference map, half 2
    inputBinding:
      position: 101
      prefix: --a2
  - id: angpix_ref
    type:
      - 'null'
      - float
    doc: 'Pixel size of the reference map (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --angpix_ref
  - id: mask
    type:
      - 'null'
      - File
    doc: Reference mask
    inputBinding:
      position: 101
      prefix: --mask
  - id: pad
    type:
      - 'null'
      - float
    doc: 'Padding factor (RELION default: 2)'
    inputBinding:
      position: 101
      prefix: --pad
  - id: first_frame
    type:
      - 'null'
      - int
    doc: 'First move frame to process (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --first_frame
  - id: last_frame
    type:
      - 'null'
      - int
    doc: 'Last movie frame to process (default is all) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --last_frame
  - id: only_do_unfinished
    type:
      - 'null'
      - boolean
    doc: Skip those steps for which output files already exist.
    inputBinding:
      position: 101
      prefix: --only_do_unfinished
  - id: verb
    type:
      - 'null'
      - int
    doc: 'Verbosity (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --verb
  - id: fdose
    type:
      - 'null'
      - float
    doc: 'Electron dose per frame (in e^-/A^2) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --fdose
  - id: s_vel
    type:
      - 'null'
      - float
    doc: 'Velocity sigma [Angst/dose] (RELION default: 0.5)'
    inputBinding:
      position: 101
      prefix: --s_vel
  - id: s_div
    type:
      - 'null'
      - float
    doc: 'Divergence sigma [Angst] (RELION default: 5000.0)'
    inputBinding:
      position: 101
      prefix: --s_div
  - id: s_acc
    type:
      - 'null'
      - float
    doc: 'Acceleration sigma [Angst/dose] (RELION default: 2.0)'
    inputBinding:
      position: 101
      prefix: --s_acc
  - id: params_file
    type:
      - 'null'
      - File
    doc: File containing s_vel, s_div and s_acc (overrides command line parameters)
    inputBinding:
      position: 101
      prefix: --params_file
  - id: only_group
    type:
      - 'null'
      - int
    doc: 'Only align micrographs containing particles from this optics group (negative means off) (RELION
      default: -1)'
    inputBinding:
      position: 101
      prefix: --only_group
  - id: diag
    type:
      - 'null'
      - boolean
    doc: Write out diagnostic data
    inputBinding:
      position: 101
      prefix: --diag
  - id: cc_pad
    type:
      - 'null'
      - float
    doc: 'Cross-correlation Fourier-padding (RELION default: 1.0)'
    inputBinding:
      position: 101
      prefix: --cc_pad
  - id: dmg_a
    type:
      - 'null'
      - float
    doc: 'Damage model, parameter a (RELION default: 3.40)'
    inputBinding:
      position: 101
      prefix: --dmg_a
  - id: dmg_b
    type:
      - 'null'
      - float
    doc: 'b (RELION default: -1.06)'
    inputBinding:
      position: 101
      prefix: --dmg_b
  - id: dmg_c
    type:
      - 'null'
      - float
    doc: 'c (RELION default: -0.54)'
    inputBinding:
      position: 101
      prefix: --dmg_c
  - id: max_iters
    type:
      - 'null'
      - float
    doc: 'Maximum number of iterations (RELION default: 10000)'
    inputBinding:
      position: 101
      prefix: --max_iters
  - id: eps
    type:
      - 'null'
      - float
    doc: 'Terminate optimization after gradient length falls below this value (RELION default: 1e-5)'
    inputBinding:
      position: 101
      prefix: --eps
  - id: no_whiten
    type:
      - 'null'
      - boolean
    doc: Do not whiten the noise spectrum
    inputBinding:
      position: 101
      prefix: --no_whiten
  - id: unreg_glob
    type:
      - 'null'
      - boolean
    doc: Do not regularize global component of motion
    inputBinding:
      position: 101
      prefix: --unreg_glob
  - id: glob_off
    type:
      - 'null'
      - boolean
    doc: Compute initial per-particle offsets
    inputBinding:
      position: 101
      prefix: --glob_off
  - id: glob_off_max
    type:
      - 'null'
      - int
    doc: 'Maximum per-particle offset range [Pixels] (RELION default: 10)'
    inputBinding:
      position: 101
      prefix: --glob_off_max
  - id: absolute_params
    type:
      - 'null'
      - boolean
    doc: Do not scale input motion parameters by dose
    inputBinding:
      position: 101
      prefix: --absolute_params
  - id: debug_opt
    type:
      - 'null'
      - boolean
    doc: Write optimization debugging info
    inputBinding:
      position: 101
      prefix: --debug_opt
  - id: gi
    type:
      - 'null'
      - boolean
    doc: Initialize with global trajectories instead of loading them from metadata file
    inputBinding:
      position: 101
      prefix: --gi
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
      - int
    doc: 'Maximum number of eigendeformations (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --max_ed
  - id: out_cut
    type:
      - 'null'
      - boolean
    doc: Do not consider frequencies beyond the 0.143-FSC threshold for alignment
    inputBinding:
      position: 101
      prefix: --out_cut
  - id: params2
    type:
      - 'null'
      - boolean
    doc: Estimate 2 parameters instead of motion
    inputBinding:
      position: 101
      prefix: --params2
  - id: params3
    type:
      - 'null'
      - boolean
    doc: Estimate 3 parameters instead of motion
    inputBinding:
      position: 101
      prefix: --params3
  - id: align_frac
    type:
      - 'null'
      - float
    doc: 'Fraction of pixels to be used for alignment (RELION default: 0.5)'
    inputBinding:
      position: 101
      prefix: --align_frac
  - id: eval_frac
    type:
      - 'null'
      - float
    doc: 'Fraction of pixels to be used for evaluation (RELION default: 0.5)'
    inputBinding:
      position: 101
      prefix: --eval_frac
  - id: min_p
    type:
      - 'null'
      - int
    doc: 'Minimum number of particles on which to estimate the parameters (RELION default: 1000)'
    inputBinding:
      position: 101
      prefix: --min_p
  - id: par_group
    type:
      - 'null'
      - int
    doc: 'Estimate parameters for this optics group only (negative means all) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --par_group
  - id: s_vel_0
    type:
      - 'null'
      - float
    doc: 'Initial s_vel (RELION default: 0.6)'
    inputBinding:
      position: 101
      prefix: --s_vel_0
  - id: s_div_0
    type:
      - 'null'
      - float
    doc: 'Initial s_div (RELION default: 10000)'
    inputBinding:
      position: 101
      prefix: --s_div_0
  - id: s_acc_0
    type:
      - 'null'
      - float
    doc: 'Initial s_acc (RELION default: 3)'
    inputBinding:
      position: 101
      prefix: --s_acc_0
  - id: in_step
    type:
      - 'null'
      - float
    doc: 'Initial step size in s_div (RELION default: 3000)'
    inputBinding:
      position: 101
      prefix: --in_step
  - id: conv
    type:
      - 'null'
      - float
    doc: 'Abort when simplex diameter falls below this (RELION default: 30)'
    inputBinding:
      position: 101
      prefix: --conv
  - id: par_iters
    type:
      - 'null'
      - float
    doc: 'Max. number of iterations (RELION default: 100)'
    inputBinding:
      position: 101
      prefix: --par_iters
  - id: mot_range
    type:
      - 'null'
      - int
    doc: 'Limit allowed motion range [Px] (RELION default: 50)'
    inputBinding:
      position: 101
      prefix: --mot_range
  - id: seed
    type:
      - 'null'
      - int
    doc: 'Random seed for micrograph selection (RELION default: 23)'
    inputBinding:
      position: 101
      prefix: --seed
  - id: combine_frames
    type:
      - 'null'
      - boolean
    doc: Combine movie frames into polished particles.
    inputBinding:
      position: 101
      prefix: --combine_frames
  - id: float16
    type:
      - 'null'
      - boolean
    doc: Write in half-precision 16 bit floating point numbers (MRC mode 12), instead of 32 bit (MRC mode
      0).
    inputBinding:
      position: 101
      prefix: --float16
  - id: scale
    type:
      - 'null'
      - int
    doc: 'Re-scale the particles to this size (by default read from particles star file) (RELION default:
      -1)'
    inputBinding:
      position: 101
      prefix: --scale
  - id: window
    type:
      - 'null'
      - int
    doc: 'Re-window the particles to this size (in movie-pixels; by default read from particles star file)
      (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --window
  - id: crop
    type:
      - 'null'
      - int
    doc: 'Crop the scaled particles to this size after CTF pre-multiplication (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --crop
  - id: ctf_multiply
    type:
      - 'null'
      - boolean
    doc: Premultiply by CTF.
    inputBinding:
      position: 101
      prefix: --ctf_multiply
  - id: bfac_minfreq
    type:
      - 'null'
      - float
    doc: 'Min. frequency used in B-factor fit [Angst] (RELION default: 20)'
    inputBinding:
      position: 101
      prefix: --bfac_minfreq
  - id: bfac_maxfreq
    type:
      - 'null'
      - float
    doc: 'Max. frequency used in B-factor fit [Angst] (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --bfac_maxfreq
  - id: bfactors
    type:
      - 'null'
      - File
    doc: A .star file with external B/k-factors
    inputBinding:
      position: 101
      prefix: --bfactors
  - id: diag_bfactor
    type:
      - 'null'
      - boolean
    doc: Write out B/k-factor diagnostic data
    inputBinding:
      position: 101
      prefix: --diag_bfactor
  - id: suffix
    type:
      - 'null'
      - string
    doc: Add this suffix to shiny MRCS and STAR files
    inputBinding:
      position: 101
      prefix: --suffix
  - id: recenter
    type:
      - 'null'
      - boolean
    doc: Re-center particle according to rlnOriginX/Y in --reextract_data_star STAR file
    inputBinding:
      position: 101
      prefix: --recenter
  - id: recenter_x
    type:
      - 'null'
      - float
    doc: 'X-coordinate (in pixel inside the reference) to recenter re-extracted data on (RELION default:
      0.)'
    inputBinding:
      position: 101
      prefix: --recenter_x
  - id: recenter_y
    type:
      - 'null'
      - float
    doc: 'Y-coordinate (in pixel inside the reference) to recenter re-extracted data on (RELION default:
      0.)'
    inputBinding:
      position: 101
      prefix: --recenter_y
  - id: recenter_z
    type:
      - 'null'
      - float
    doc: 'Z-coordinate (in pixel inside the reference) to recenter re-extracted data on (RELION default:
      0.)'
    inputBinding:
      position: 101
      prefix: --recenter_z
  - id: threads
    type:
      - 'null'
      - int
    doc: 'Number of (OMP) threads (RELION default: 1)'
    inputBinding:
      position: 101
      prefix: --j
  - id: B_parts
    type:
      - 'null'
      - float
    doc: 'Number of particles used for B-factor estimation (negative means all) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --B_parts
  - id: min_MG
    type:
      - 'null'
      - int
    doc: 'First micrograph index (RELION default: 0)'
    inputBinding:
      position: 101
      prefix: --min_MG
  - id: max_MG
    type:
      - 'null'
      - int
    doc: 'Last micrograph index (default is to process all) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --max_MG
  - id: sbs
    type:
      - 'null'
      - boolean
    doc: Load movies slice-by-slice to save memory (slower)
    inputBinding:
      position: 101
      prefix: --sbs
  - id: corr_mic
    type: File
    doc: List of uncorrected micrographs (e.g. corrected_micrographs.star)
    inputBinding:
      position: 101
      prefix: --corr_mic
  - id: find_shortest
    type:
      - 'null'
      - boolean
    doc: Load only as many frames as are present in all movies.
    inputBinding:
      position: 101
      prefix: --find_shortest
  - id: debug
    type:
      - 'null'
      - boolean
    doc: Write debugging data
    inputBinding:
      position: 101
      prefix: --debug
  - id: mps
    type:
      - 'null'
      - float
    doc: 'Pixel size of input movies (Angst/pix) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --mps
  - id: cps
    type:
      - 'null'
      - float
    doc: 'Pixel size of particle coordinates in star-file (Angst/pix) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --cps
  - id: hot
    type:
      - 'null'
      - int
    doc: 'Clip hot pixels to this max. value (-1 = off, TIFF only) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --hot
  - id: debug_mov
    type:
      - 'null'
      - boolean
    doc: Write debugging data for movie loading
    inputBinding:
      position: 101
      prefix: --debug_mov
  - id: mov_toReplace
    type:
      - 'null'
      - string
    doc: Replace this string in micrograph names...
    inputBinding:
      position: 101
      prefix: --mov_toReplace
  - id: mov_replaceBy
    type:
      - 'null'
      - string
    doc: ..by this one
    inputBinding:
      position: 101
      prefix: --mov_replaceBy
  - id: eer_upsampling
    type:
      - 'null'
      - int
    doc: 'EER upsampling (1 = physical or 2 = 2x super-resolution) (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --eer_upsampling
  - id: eer_grouping
    type:
      - 'null'
      - int
    doc: 'EER grouping (RELION default: -1)'
    inputBinding:
      position: 101
      prefix: --eer_grouping
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
    doc: Output directory
    outputBinding:
      glob: $(inputs.output)
  - id: log
    type: stdout
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_motion_refine.out
