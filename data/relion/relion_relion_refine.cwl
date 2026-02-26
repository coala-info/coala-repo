cwlVersion: v1.2
class: CommandLineTool
baseCommand: relion_relion_refine
label: relion_relion_refine
doc: "RELION: command line arguments\n\nTool homepage: https://github.com/3dem/relion"
inputs:
  - id: adaptive_oversampling_fraction
    type:
      - 'null'
      - float
    doc: Fraction of the weights to be considered in the first pass of adaptive 
      oversampling
    default: 0.999
    inputBinding:
      position: 101
      prefix: --adaptive_fraction
  - id: allow_coarser_sampling
    type:
      - 'null'
      - boolean
    doc: In 2D/3D classification, allow coarser angular and translational 
      samplings if accuracies are bad (typically in earlier iterations.
    default: false
    inputBinding:
      position: 101
      prefix: --allow_coarser_sampling
  - id: always_cc
    type:
      - 'null'
      - boolean
    doc: Perform CC-calculation in all iterations (useful for faster denovo 
      model generation?)
    default: false
    inputBinding:
      position: 101
      prefix: --always_cc
  - id: auto_ignore_angles
    type:
      - 'null'
      - boolean
    doc: In auto-refinement, update angular sampling regardless of changes in 
      orientations for convergence. This makes convergence faster.
    default: false
    inputBinding:
      position: 101
      prefix: --auto_ignore_angles
  - id: auto_local_healpix_order
    type:
      - 'null'
      - int
    doc: Minimum healpix order (before oversampling) from which autosampling 
      procedure will use local searches
    default: 4
    inputBinding:
      position: 101
      prefix: --auto_local_healpix_order
  - id: auto_refine
    type:
      - 'null'
      - boolean
    doc: Perform 3D auto-refine procedure?
    default: false
    inputBinding:
      position: 101
      prefix: --auto_refine
  - id: auto_refinement_max_iterations
    type:
      - 'null'
      - int
    doc: In auto-refinement, stop at this iteration.
    default: 999
    inputBinding:
      position: 101
      prefix: --auto_iter_max
  - id: auto_resol_angles
    type:
      - 'null'
      - boolean
    doc: In auto-refinement, update angular sampling based on resolution-based 
      required sampling. This makes convergence faster.
    default: false
    inputBinding:
      position: 101
      prefix: --auto_resol_angles
  - id: auto_sampling
    type:
      - 'null'
      - boolean
    doc: Perform auto-sampling (outside the 3D auto-refine procedure)?
    default: false
    inputBinding:
      position: 101
      prefix: --auto_sampling
  - id: bimodal_psi
    type:
      - 'null'
      - boolean
    doc: Do bimodal searches of psi angle?
    default: false
    inputBinding:
      position: 101
      prefix: --bimodal_psi
  - id: blush_skip_spectral_trailing
    type:
      - 'null'
      - boolean
    doc: 'Skip spectral trailing during Blush reconstruction (WARNING: This may inflate
      resolution estimates)'
    default: false
    inputBinding:
      position: 101
      prefix: --blush_skip_spectral_trailing
  - id: center_classes
    type:
      - 'null'
      - boolean
    doc: Re-center classes based on their center-of-mass?
    default: false
    inputBinding:
      position: 101
      prefix: --center_classes
  - id: class_inactivity_threshold
    type:
      - 'null'
      - int
    doc: Replace classes with little activity during gradient based 
      classification.
    default: 0
    inputBinding:
      position: 101
      prefix: --class_inactivity_threshold
  - id: coarse_image_size
    type:
      - 'null'
      - int
    doc: Maximum image size for the first pass of the adaptive sampling approach
    default: -1
    inputBinding:
      position: 101
      prefix: --coarse_size
  - id: ctf3d_not_squared
    type:
      - 'null'
      - boolean
    doc: CTF3D files contain sqrt(CTF^2) patterns
    default: false
    inputBinding:
      position: 101
      prefix: --ctf3d_not_squared
  - id: ctf_correction
    type:
      - 'null'
      - boolean
    doc: Perform CTF correction?
    default: false
    inputBinding:
      position: 101
      prefix: --ctf
  - id: ctf_intact_first_peak
    type:
      - 'null'
      - boolean
    doc: Ignore CTFs until their first peak?
    default: false
    inputBinding:
      position: 101
      prefix: --ctf_intact_first_peak
  - id: ctf_phase_flipped
    type:
      - 'null'
      - boolean
    doc: Have the data been CTF phase-flipped?
    default: false
    inputBinding:
      position: 101
      prefix: --ctf_phase_flipped
  - id: ctf_uncorrected_ref
    type:
      - 'null'
      - boolean
    doc: Have the input references not been CTF-amplitude corrected?
    default: false
    inputBinding:
      position: 101
      prefix: --ctf_uncorrected_ref
  - id: denovo_3d_refinement
    type:
      - 'null'
      - boolean
    doc: Make an initial 3D model from randomly oriented 2D particles
    default: false
    inputBinding:
      position: 101
      prefix: --denovo_3dref
  - id: dont_check_normalization
    type:
      - 'null'
      - boolean
    doc: Skip the check whether the images are normalised correctly
    default: false
    inputBinding:
      position: 101
      prefix: --dont_check_norm
  - id: dont_combine_weights_via_disc
    type:
      - 'null'
      - boolean
    doc: Send the large arrays of summed weights through the MPI network, 
      instead of writing large files to disc
    default: false
    inputBinding:
      position: 101
      prefix: --dont_combine_weights_via_disc
  - id: dont_skip_gridding
    type:
      - 'null'
      - boolean
    doc: Perform gridding in the reconstruction step (obsolete?)
    default: false
    inputBinding:
      position: 101
      prefix: --dont_skip_gridding
  - id: external_reconstruction
    type:
      - 'null'
      - boolean
    doc: Perform the reconstruction step outside relion_refine, e.g. for learned
      priors?)
    default: false
    inputBinding:
      position: 101
      prefix: --external_reconstruct
  - id: failsafe_threshold
    type:
      - 'null'
      - int
    doc: Maximum number of particles permitted to be handled by fail-safe mode, 
      due to zero sum of weights, before exiting with an error (GPU only).
    default: 40
    inputBinding:
      position: 101
      prefix: --failsafe_threshold
  - id: fast_subsets
    type:
      - 'null'
      - boolean
    doc: Use faster optimisation by using subsets of the data in the first 15 
      iterations
    default: false
    inputBinding:
      position: 101
      prefix: --fast_subsets
  - id: first_iter_cc
    type:
      - 'null'
      - boolean
    doc: Perform CC-calculation in the first iteration (use this if references 
      are not on the absolute intensity scale)
    default: false
    inputBinding:
      position: 101
      prefix: --firstiter_cc
  - id: fix_sigma_noise
    type:
      - 'null'
      - boolean
    doc: Fix the experimental noise spectra?
    default: false
    inputBinding:
      position: 101
      prefix: --fix_sigma_noise
  - id: fix_sigma_offset
    type:
      - 'null'
      - boolean
    doc: Fix the stddev in the origin offsets?
    default: false
    inputBinding:
      position: 101
      prefix: --fix_sigma_offset
  - id: flatten_solvent
    type:
      - 'null'
      - boolean
    doc: Perform masking on the references as well?
    default: false
    inputBinding:
      position: 101
      prefix: --flatten_solvent
  - id: fourier_mask_file
    type:
      - 'null'
      - File
    doc: Originally-sized, FFTW-centred image with Fourier mask for Projector
    default: None
    inputBinding:
      position: 101
      prefix: --fourier_mask
  - id: fourier_transform_oversampling
    type:
      - 'null'
      - int
    doc: Oversampling factor for the Fourier transforms of the references
    default: 2
    inputBinding:
      position: 101
      prefix: --pad
  - id: free_gpu_memory_mb
    type:
      - 'null'
      - int
    doc: GPU device memory (in Mb) to leave free after allocation.
    default: 0
    inputBinding:
      position: 101
      prefix: --free_gpu_memory
  - id: grad_em_iterations
    type:
      - 'null'
      - int
    doc: Number of iterations at the end of a gradient refinement using 
      Expectation-Maximization
    default: 0
    inputBinding:
      position: 101
      prefix: --grad_em_iters
  - id: grad_final_fraction
    type:
      - 'null'
      - float
    doc: Fraction of iterations in the final phase of refinement
    default: 0.2
    inputBinding:
      position: 101
      prefix: --grad_fin_frac
  - id: grad_final_resolution
    type:
      - 'null'
      - float
    doc: Resolution cutoff during the final gradient refinement iterations (A)
    default: -1
    inputBinding:
      position: 101
      prefix: --grad_fin_resol
  - id: grad_final_subset
    type:
      - 'null'
      - int
    doc: Mini-batch size during the final gradient refinement iterations
    default: -1
    inputBinding:
      position: 101
      prefix: --grad_fin_subset
  - id: grad_initial_fraction
    type:
      - 'null'
      - float
    doc: Fraction of iterations in the initial phase of refinement
    default: 0.3
    inputBinding:
      position: 101
      prefix: --grad_ini_frac
  - id: grad_initial_resolution
    type:
      - 'null'
      - float
    doc: Resolution cutoff during the initial gradient refinement iterations (A)
    default: -1
    inputBinding:
      position: 101
      prefix: --grad_ini_resol
  - id: grad_initial_subset
    type:
      - 'null'
      - int
    doc: Mini-batch size during the initial gradient refinement iterations
    default: -1
    inputBinding:
      position: 101
      prefix: --grad_ini_subset
  - id: grad_min_resolution
    type:
      - 'null'
      - float
    doc: Adjusting the signal under-estimation during gradient optimization to 
      this resolution.
    default: 20
    inputBinding:
      position: 101
      prefix: --grad_min_resol
  - id: grad_stepsize
    type:
      - 'null'
      - float
    doc: Step size parameter for gradient optimisation.
    default: -1
    inputBinding:
      position: 101
      prefix: --grad_stepsize
  - id: grad_stepsize_scheme
    type:
      - 'null'
      - string
    doc: Gradient step size updates scheme. Valid values are plain or 
      <inflate>-step . Where <inflate> is the initial inflate.
    inputBinding:
      position: 101
      prefix: --grad_stepsize_scheme
  - id: grad_write_iteration
    type:
      - 'null'
      - int
    doc: Write out model every so many iterations in SGD (default is writing out
      all iters)
    default: 10
    inputBinding:
      position: 101
      prefix: --grad_write_iter
  - id: gradient_optimization
    type:
      - 'null'
      - boolean
    doc: Perform gradient based optimisation (instead of default 
      expectation-maximization)
    default: false
    inputBinding:
      position: 101
      prefix: --grad
  - id: healpix_order
    type:
      - 'null'
      - int
    doc: 'Healpix order for the angular sampling (before oversampling) on the (3D)
      sphere: hp2=15deg, hp3=7.5deg, etc'
    default: 2
    inputBinding:
      position: 101
      prefix: --healpix_order
  - id: helical_exclude_resolutions
    type:
      - 'null'
      - string
    doc: Resolutions (in A) along helical axis to exclude from refinement 
      (comma-separated pairs, e.g. 50,5)
    inputBinding:
      position: 101
      prefix: --helical_exclude_resols
  - id: helical_inner_diameter
    type:
      - 'null'
      - float
    doc: Inner diameter of helical tubes in Angstroms (for masks of helical 
      references and particles)
    default: -1.0
    inputBinding:
      position: 101
      prefix: --helical_inner_diameter
  - id: helical_keep_tilt_prior_fixed
    type:
      - 'null'
      - boolean
    doc: Keep helical tilt priors fixed (at 90 degrees) in global angular 
      searches?
    default: false
    inputBinding:
      position: 101
      prefix: --helical_keep_tilt_prior_fixed
  - id: helical_nstart
    type:
      - 'null'
      - int
    doc: N-number for the N-start helix (only useful for rotational priors)
    default: 1
    inputBinding:
      position: 101
      prefix: --helical_nstart
  - id: helical_num_asu
    type:
      - 'null'
      - int
    doc: Number of new helical asymmetric units (asu) per box (1 means no 
      helical symmetry is present)
    default: 1
    inputBinding:
      position: 101
      prefix: --helical_nr_asu
  - id: helical_offset_step_angstroms
    type:
      - 'null'
      - float
    doc: Sampling rate (before oversampling) for offsets along helical axis (in 
      Angstroms)
    default: -1
    inputBinding:
      position: 101
      prefix: --helical_offset_step
  - id: helical_outer_diameter
    type:
      - 'null'
      - float
    doc: Outer diameter of helical tubes in Angstroms (for masks of helical 
      references and particles)
    default: -1.0
    inputBinding:
      position: 101
      prefix: --helical_outer_diameter
  - id: helical_rise_initial
    type:
      - 'null'
      - float
    doc: Helical rise (in Angstroms)
    default: 0.0
    inputBinding:
      position: 101
      prefix: --helical_rise_initial
  - id: helical_rise_initial_step
    type:
      - 'null'
      - float
    doc: Initial step of helical rise search (in Angstroms)
    default: 0.0
    inputBinding:
      position: 101
      prefix: --helical_rise_inistep
  - id: helical_rise_max
    type:
      - 'null'
      - float
    doc: Maximum helical rise (in Angstroms)
    default: 0.0
    inputBinding:
      position: 101
      prefix: --helical_rise_max
  - id: helical_rise_min
    type:
      - 'null'
      - float
    doc: Minimum helical rise (in Angstroms)
    default: 0.0
    inputBinding:
      position: 101
      prefix: --helical_rise_min
  - id: helical_sigma_distance
    type:
      - 'null'
      - float
    doc: Sigma of distance along the helical tracks
    default: -1.0
    inputBinding:
      position: 101
      prefix: --helical_sigma_distance
  - id: helical_symmetry_search
    type:
      - 'null'
      - boolean
    doc: Perform local refinement of helical symmetry?
    default: false
    inputBinding:
      position: 101
      prefix: --helical_symmetry_search
  - id: helical_twist_initial
    type:
      - 'null'
      - float
    doc: Helical twist (in degrees, positive values for right-handedness)
    default: 0.0
    inputBinding:
      position: 101
      prefix: --helical_twist_initial
  - id: helical_twist_initial_step
    type:
      - 'null'
      - float
    doc: Initial step of helical twist search (in degrees)
    default: 0.0
    inputBinding:
      position: 101
      prefix: --helical_twist_inistep
  - id: helical_twist_max
    type:
      - 'null'
      - float
    doc: Maximum helical twist (in degrees, positive values for 
      right-handedness)
    default: 0.0
    inputBinding:
      position: 101
      prefix: --helical_twist_max
  - id: helical_twist_min
    type:
      - 'null'
      - float
    doc: Minimum helical twist (in degrees, positive values for 
      right-handedness)
    default: 0.0
    inputBinding:
      position: 101
      prefix: --helical_twist_min
  - id: helical_z_percentage
    type:
      - 'null'
      - float
    doc: This box length along the center of Z axis contains good information of
      the helix. Important in imposing and refining symmetry
    default: 0.3
    inputBinding:
      position: 101
      prefix: --helical_z_percentage
  - id: ignore_helical_symmetry
    type:
      - 'null'
      - boolean
    doc: Ignore helical symmetry?
    default: false
    inputBinding:
      position: 101
      prefix: --ignore_helical_symmetry
  - id: increment_fourier_shells
    type:
      - 'null'
      - int
    doc: Number of Fourier shells beyond the current resolution to be included 
      in refinement
    default: 10
    inputBinding:
      position: 101
      prefix: --incr_size
  - id: initial_high_resolution
    type:
      - 'null'
      - float
    doc: Resolution (in Angstroms) to which to limit refinement in the first 
      iteration
    default: -1
    inputBinding:
      position: 101
      prefix: --ini_high
  - id: initial_offset_stddev
    type:
      - 'null'
      - float
    doc: Initial estimated stddev for the origin offsets (in Angstroms)
    default: 10
    inputBinding:
      position: 101
      prefix: --offset
  - id: input_optimiser_set
    type:
      - 'null'
      - string
    doc: Input tomo optimisation set file. It is used to set --i, --tomograms, 
      --ref or --solvent_mask if they are not provided. Updated output optimiser
      set is created.
    inputBinding:
      position: 101
      prefix: --ios
  - id: input_particles
    type:
      - 'null'
      - string
    doc: Input particles (in a star-file)
    inputBinding:
      position: 101
      prefix: --i
  - id: intensity_scale_correction
    type:
      - 'null'
      - boolean
    doc: Perform intensity-scale corrections on image groups?
    default: false
    inputBinding:
      position: 101
      prefix: --scale
  - id: keep_free_scratch_gb
    type:
      - 'null'
      - int
    doc: Space available for copying particle stacks (in Gb)
    default: 10
    inputBinding:
      position: 101
      prefix: --keep_free_scratch
  - id: keep_scratch
    type:
      - 'null'
      - boolean
    doc: Don't remove scratch after convergence. Following jobs that use EXACTLY
      the same particles should use --reuse_scratch.
    default: false
    inputBinding:
      position: 101
      prefix: --keep_scratch
  - id: limit_tilt
    type:
      - 'null'
      - float
    doc: 'Limited tilt angle: positive for keeping side views, negative for keeping
      top views'
    default: -91
    inputBinding:
      position: 101
      prefix: --limit_tilt
  - id: local_symmetry_file
    type:
      - 'null'
      - File
    doc: Local symmetry description file containing list of masks and their 
      operators
    default: None
    inputBinding:
      position: 101
      prefix: --local_symmetry
  - id: low_resol_join_halves
    type:
      - 'null'
      - float
    doc: Resolution (in Angstrom) up to which the two random 
      half-reconstructions will not be independent to prevent diverging 
      orientations
    default: -1
    inputBinding:
      position: 101
      prefix: --low_resol_join_halves
  - id: lowpass
    type:
      - 'null'
      - float
    doc: User-provided cutoff for region specified above
    default: 0
    inputBinding:
      position: 101
      prefix: --lowpass
  - id: lowpass_mask
    type:
      - 'null'
      - File
    doc: User-provided mask for low-pass filtering
    default: None
    inputBinding:
      position: 101
      prefix: --lowpass_mask
  - id: mask_edge_width_pixels
    type:
      - 'null'
      - int
    doc: Width of the soft edge of the spherical mask (in pixels)
    default: 5
    inputBinding:
      position: 101
      prefix: --maskedge
  - id: max_iterations
    type:
      - 'null'
      - int
    doc: Maximum number of iterations to perform
    default: -1
    inputBinding:
      position: 101
      prefix: --iter
  - id: max_significant_poses
    type:
      - 'null'
      - int
    doc: Maximum number of most significant poses & translations to consider
    default: -1
    inputBinding:
      position: 101
      prefix: --maxsig
  - id: min_fourier_shells_nn
    type:
      - 'null'
      - int
    doc: Minimum number of Fourier shells to perform linear Fourier-space 
      interpolation
    default: 10
    inputBinding:
      position: 101
      prefix: --r_min_nn
  - id: momentum_parameter
    type:
      - 'null'
      - float
    doc: Momentum parameter for gradient refinement updates
    default: 0.9
    inputBinding:
      position: 101
      prefix: --mu
  - id: nearest_neighbor_interpolation
    type:
      - 'null'
      - boolean
    doc: Perform nearest-neighbour instead of linear Fourier-space 
      interpolation?
    default: false
    inputBinding:
      position: 101
      prefix: --NN
  - id: no_initial_blobs
    type:
      - 'null'
      - boolean
    doc: Use this to switch off initializing models with random Gaussians (which
      is new in relion-4.0).
    default: false
    inputBinding:
      position: 101
      prefix: --no_init_blobs
  - id: no_intensity_scale_correction
    type:
      - 'null'
      - boolean
    doc: Switch off intensity-scale corrections on image groups?
    default: false
    inputBinding:
      position: 101
      prefix: --no_scale
  - id: no_normalization_correction
    type:
      - 'null'
      - boolean
    doc: Switch off normalisation-error correction?
    default: false
    inputBinding:
      position: 101
      prefix: --no_norm
  - id: no_parallel_disc_io
    type:
      - 'null'
      - boolean
    doc: Do NOT let parallel (MPI) processes access the disc simultaneously (use
      this option with NFS)
    default: false
    inputBinding:
      position: 101
      prefix: --no_parallel_disc_io
  - id: normalization_correction
    type:
      - 'null'
      - boolean
    doc: Perform normalisation-error correction?
    default: false
    inputBinding:
      position: 101
      prefix: --norm
  - id: normalized_subtomo
    type:
      - 'null'
      - boolean
    doc: Have subtomograms been multiplicity normalised? (Default=False)
    default: false
    inputBinding:
      position: 101
      prefix: --normalised_subtomo
  - id: num_parts_sigma2noise
    type:
      - 'null'
      - int
    doc: Number of particles (per optics group) for initial noise spectra 
      estimation (default 1000 for SPA and 100 for STA).
    default: -1
    inputBinding:
      position: 101
      prefix: --nr_parts_sigma2noise
  - id: num_references
    type:
      - 'null'
      - int
    doc: Number of references to be refined
    default: 1
    inputBinding:
      position: 101
      prefix: --K
  - id: num_threads
    type:
      - 'null'
      - int
    doc: Number of threads to run in parallel (only useful on multi-core 
      machines)
    default: 1
    inputBinding:
      position: 101
      prefix: -j
  - id: offset_range_pixels
    type:
      - 'null'
      - float
    doc: Search range for origin offsets (in pixels)
    default: 6
    inputBinding:
      position: 101
      prefix: --offset_range
  - id: offset_range_x_angstroms
    type:
      - 'null'
      - float
    doc: Range for sampling offsets in X-direction (in Angstrom; default=auto)
    default: -1
    inputBinding:
      position: 101
      prefix: --offset_range_x
  - id: offset_range_y_angstroms
    type:
      - 'null'
      - float
    doc: Range for sampling offsets in Y-direction (in Angstrom; default=auto)
    default: -1
    inputBinding:
      position: 101
      prefix: --offset_range_y
  - id: offset_range_z_angstroms
    type:
      - 'null'
      - float
    doc: Range for sampling offsets in Z-direction (in Angstrom; default=auto)
    default: -1
    inputBinding:
      position: 101
      prefix: --offset_range_z
  - id: offset_step_pixels
    type:
      - 'null'
      - float
    doc: Sampling rate (before oversampling) for origin offsets (in pixels)
    default: 2
    inputBinding:
      position: 101
      prefix: --offset_step
  - id: only_flip_phases
    type:
      - 'null'
      - boolean
    doc: Only perform CTF phase-flipping? (default is full amplitude-correction)
    default: false
    inputBinding:
      position: 101
      prefix: --only_flip_phases
  - id: onthefly_shifts
    type:
      - 'null'
      - boolean
    doc: Calculate shifted images on-the-fly, do not store precalculated ones in
      memory
    default: false
    inputBinding:
      position: 101
      prefix: --onthefly_shifts
  - id: output_rootname
    type:
      - 'null'
      - string
    doc: Output rootname
    inputBinding:
      position: 101
      prefix: --o
  - id: oversampling_order
    type:
      - 'null'
      - int
    doc: Adaptive oversampling order to speed-up calculations (0=no 
      oversampling, 1=2x, 2=4x, etc)
    default: 1
    inputBinding:
      position: 101
      prefix: --oversampling
  - id: pad_ctf
    type:
      - 'null'
      - boolean
    doc: Perform CTF padding to treat CTF aliaising better?
    default: false
    inputBinding:
      position: 101
      prefix: --pad_ctf
  - id: particle_diameter
    type:
      - 'null'
      - float
    doc: Diameter of the circular mask that will be applied to the experimental 
      images (in Angstroms)
    default: -1
    inputBinding:
      position: 101
      prefix: --particle_diameter
  - id: perform_helix_reconstruction
    type:
      - 'null'
      - boolean
    doc: Perform 3D classification or refinement for helices?
    default: false
    inputBinding:
      position: 101
      prefix: --helix
  - id: perturbation_factor
    type:
      - 'null'
      - float
    doc: Perturbation factor for the angular sampling (0=no perturb; 
      0.5=perturb)
    default: 0.5
    inputBinding:
      position: 101
      prefix: --perturb
  - id: pool_images
    type:
      - 'null'
      - int
    doc: Number of images to pool for each thread task
    default: 1
    inputBinding:
      position: 101
      prefix: --pool
  - id: preread_images
    type:
      - 'null'
      - boolean
    doc: Use this to let the leader process read all particles into memory. Be 
      careful you have enough RAM for large data sets!
    default: false
    inputBinding:
      position: 101
      prefix: --preread_images
  - id: print_metadata_labels
    type:
      - 'null'
      - boolean
    doc: Print a table with definitions of all metadata labels, and exit
    default: false
    inputBinding:
      position: 101
      prefix: --print_metadata_labels
  - id: print_symmetry_operations
    type:
      - 'null'
      - boolean
    doc: Print all symmetry transformation matrices, and exit
    default: false
    inputBinding:
      position: 101
      prefix: --print_symmetry_ops
  - id: psi_step
    type:
      - 'null'
      - float
    doc: Sampling rate (before oversampling) for the in-plane angle 
      (default=10deg for 2D, hp sampling for 3D)
    default: -1
    inputBinding:
      position: 101
      prefix: --psi_step
  - id: random_seed
    type:
      - 'null'
      - int
    doc: Number for the random seed generator
    default: -1
    inputBinding:
      position: 101
      prefix: --random_seed
  - id: reference_input
    type:
      - 'null'
      - File
    doc: Image, stack or star-file with the reference(s). (Compulsory for 3D 
      refinement!)
    default: None
    inputBinding:
      position: 101
      prefix: --ref
  - id: reference_pixel_size
    type:
      - 'null'
      - float
    doc: Pixel size (in A) for the input reference (default is to read from 
      header)
    default: -1.0
    inputBinding:
      position: 101
      prefix: --ref_angpix
  - id: relax_symmetry
    type:
      - 'null'
      - string
    doc: Symmetry to be relaxed
    inputBinding:
      position: 101
      prefix: --relax_sym
  - id: reuse_scratch
    type:
      - 'null'
      - boolean
    doc: Re-use data on scratchdir, instead of wiping it and re-copying all 
      data.
    default: false
    inputBinding:
      position: 101
      prefix: --reuse_scratch
  - id: scratch_directory
    type:
      - 'null'
      - Directory
    doc: If provided, particle stacks will be copied to this local scratch disk 
      prior to refinement.
    inputBinding:
      position: 101
      prefix: --scratch_dir
  - id: self_organizing_map
    type:
      - 'null'
      - boolean
    doc: Calculate self-organizing map instead of classification.
    default: false
    inputBinding:
      position: 101
      prefix: --som
  - id: sigma_angular_stddev
    type:
      - 'null'
      - float
    doc: Stddev on all three Euler angles for local angular searches (of +/- 3 
      stddev)
    default: -1
    inputBinding:
      position: 101
      prefix: --sigma_ang
  - id: sigma_psi_stddev
    type:
      - 'null'
      - float
    doc: Stddev on the in-plane angle for local angular searches (of +/- 3 
      stddev)
    default: -1
    inputBinding:
      position: 101
      prefix: --sigma_psi
  - id: sigma_rotation_stddev
    type:
      - 'null'
      - float
    doc: Stddev on the first Euler angle for local angular searches (of +/- 3 
      stddev)
    default: -1
    inputBinding:
      position: 101
      prefix: --sigma_rot
  - id: sigma_tilt_stddev
    type:
      - 'null'
      - float
    doc: Stddev on the second Euler angle for local angular searches (of +/- 3 
      stddev)
    default: -1
    inputBinding:
      position: 101
      prefix: --sigma_tilt
  - id: skip_alignment
    type:
      - 'null'
      - boolean
    doc: Skip orientational assignment (only classify)?
    default: false
    inputBinding:
      position: 101
      prefix: --skip_align
  - id: skip_maximization
    type:
      - 'null'
      - boolean
    doc: Skip maximization step (only write out data.star file)?
    default: false
    inputBinding:
      position: 101
      prefix: --skip_maximize
  - id: skip_rotation
    type:
      - 'null'
      - boolean
    doc: Skip rotational assignment (only translate and classify)?
    default: false
    inputBinding:
      position: 101
      prefix: --skip_rotate
  - id: skip_subtomo_multiplicity_correction
    type:
      - 'null'
      - boolean
    doc: Skip subtomo multiplicity correction
    default: false
    inputBinding:
      position: 101
      prefix: --skip_subtomo_multi
  - id: solvent_correct_fsc
    type:
      - 'null'
      - boolean
    doc: Correct FSC curve for the effects of the solvent mask?
    default: false
    inputBinding:
      position: 101
      prefix: --solvent_correct_fsc
  - id: solvent_mask
    type:
      - 'null'
      - File
    doc: User-provided mask for the references (default is to use spherical mask
      with particle_diameter)
    default: None
    inputBinding:
      position: 101
      prefix: --solvent_mask
  - id: solvent_mask2
    type:
      - 'null'
      - File
    doc: User-provided secondary mask (with its own average density)
    default: None
    inputBinding:
      position: 101
      prefix: --solvent_mask2
  - id: som_connectivity
    type:
      - 'null'
      - float
    doc: Number of average active neighbour connections.
    default: 5.0
    inputBinding:
      position: 101
      prefix: --som_connectivity
  - id: som_inactivity_threshold
    type:
      - 'null'
      - float
    doc: Threshold for inactivity before node is dropped.
    default: 0.01
    inputBinding:
      position: 101
      prefix: --som_inactivity_threshold
  - id: som_initial_nodes
    type:
      - 'null'
      - int
    doc: Number of initial SOM nodes.
    default: 2
    inputBinding:
      position: 101
      prefix: --som_ini_nodes
  - id: som_neighbour_pull
    type:
      - 'null'
      - float
    doc: Portion of gradient applied to connected nodes.
    default: 0.2
    inputBinding:
      position: 101
      prefix: --som_neighbour_pull
  - id: split_random_halves
    type:
      - 'null'
      - boolean
    doc: Refine two random halves of the data completely separately
    default: false
    inputBinding:
      position: 101
      prefix: --split_random_halves
  - id: strict_highres_expectation
    type:
      - 'null'
      - float
    doc: High resolution limit (in Angstrom) to restrict probability 
      calculations in the expectation step
    default: -1
    inputBinding:
      position: 101
      prefix: --strict_highres_exp
  - id: strict_lowres_expectation
    type:
      - 'null'
      - float
    doc: Low resolution limit (in Angstrom) to restrict probability calculations
      in the expectation step
    default: -1
    inputBinding:
      position: 101
      prefix: --strict_lowres_exp
  - id: subtomo_multi_threshold
    type:
      - 'null'
      - float
    doc: Threshold to remove marginal voxels during expectation
    default: 0.01
    inputBinding:
      position: 101
      prefix: --subtomo_multi_thr
  - id: symmetry_group
    type:
      - 'null'
      - string
    doc: Symmetry group
    default: c1
    inputBinding:
      position: 101
      prefix: --sym
  - id: tau2_fudge
    type:
      - 'null'
      - float
    doc: Regularisation parameter (values higher than 1 give more weight to the 
      data)
    default: -1
    inputBinding:
      position: 101
      prefix: --tau2_fudge
  - id: tau2_fudge_scheme
    type:
      - 'null'
      - string
    doc: Tau2 fudge factor updates scheme. Valid values are plain or 
      <deflate>-step. Where <deflate> is the deflate factor during initial 
      stage.
    inputBinding:
      position: 101
      prefix: --tau2_fudge_scheme
  - id: tau_spectrum_file
    type:
      - 'null'
      - File
    doc: STAR file with input tau2-spectrum (to be kept constant)
    default: None
    inputBinding:
      position: 101
      prefix: --tau
  - id: tomograms
    type:
      - 'null'
      - string
    doc: Star file with the tomograms, in case subtomos are handled as 2D stacks
    inputBinding:
      position: 101
      prefix: --tomograms
  - id: trajectories
    type:
      - 'null'
      - string
    doc: Star file with the tomogram motion trajectories
    inputBinding:
      position: 101
      prefix: --trajectories
  - id: trust_reference_size
    type:
      - 'null'
      - boolean
    doc: Trust the pixel and box size of the input reference; by default the 
      program will die if these are different from the first optics group of the
      data
    default: false
    inputBinding:
      position: 101
      prefix: --trust_ref_size
  - id: use_blush_algorithm
    type:
      - 'null'
      - boolean
    doc: Perform the reconstruction with the Blush algorithm.
    default: false
    inputBinding:
      position: 101
      prefix: --blush
  - id: use_cpu_vectorization
    type:
      - 'null'
      - boolean
    doc: Use intel vectorisation implementation for CPU
    default: false
    inputBinding:
      position: 101
      prefix: --cpu
  - id: use_gpu
    type:
      - 'null'
      - boolean
    doc: Use available gpu resources for some calculations
    default: false
    inputBinding:
      position: 101
      prefix: --gpu
  - id: verbosity
    type:
      - 'null'
      - int
    doc: Verbosity (1=normal, 0=silent)
    default: 1
    inputBinding:
      position: 101
      prefix: --verb
  - id: zero_mask
    type:
      - 'null'
      - boolean
    doc: Mask surrounding background in particles to zero (by default the 
      solvent area is filled with random noise)
    default: false
    inputBinding:
      position: 101
      prefix: --zero_mask
outputs:
  - id: stdout
    type: stdout
    doc: Standard output
hints:
  - class: DockerRequirement
    dockerPull: quay.io/biocontainers/relion:5.0.1--h6e3b700_0
stdout: relion_relion_refine.out
